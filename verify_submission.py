#!/usr/bin/env python3
"""Read-only submission checks. Never contacts a cloud, Git host or Kubernetes."""
from pathlib import Path
from urllib.parse import unquote
import argparse, ast, datetime, json, re, shutil, subprocess

ROOT = Path(__file__).resolve().parent
SKIP = {'.git', '.terraform', 'node_modules', '.venv', '.tools', '__pycache__', '.pytest_cache'}

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write-report', action='store_true')
    args = parser.parse_args()
    meta = json.loads((ROOT/'assignment-metadata.json').read_text())
    issues, checks = [], []
    counts = dict(markdown_links=0, png_images=0, yaml_files=0, python_files=0, bash_files=0)
    try:
        import yaml
    except ImportError:
        yaml = None
    try:
        from PIL import Image
    except ImportError:
        Image = None
    dirs = sorted(p.name for p in ROOT.glob('Assignment-*') if p.is_dir())
    if dirs != sorted(a['folder'] for a in meta):
        issues.append('Assignment directories do not match the 20-folder metadata map')
    if len(meta) != 20 or [a['session'] for a in meta] != ['01-02']+[f'{s:02}' for s in range(3,22)]:
        issues.append('Expected 20 assignments: Sessions 1+2, then 3 through 21')
    extra_required = {
        1:['system-information.sh'],2:['networking.md'],3:['exercise-history.bundle'],
        4:[f'{x}/Dockerfile' for x in ['nodejs-app','python-app','java-app','Apache-app','React-app','nginx-app']],
        5:['multi-stage-app/Dockerfile'],11:['secret.yaml.example','manifests/configmap.yaml','manifests/ingress.yaml'],10:['fqdn/README.md','coredns/README.md'],
        12:['01-kubernetes-volumes/README.md','hpa/hpa.yml'],
        14:['mini-project/notes-chart/Chart.yaml','mini-project/notes-chart/values.yaml'],
        15:['Dockerfile','.github/workflows/ci.yml','.github/workflows/cd.yml'],
        16:['Dockerfile','.github/workflows/devsecops.yml','security/gate.sh'],
        17:[f'terraform-s3-demo/{f}' for f in ['main.tf','variables.tf','outputs.tf','provider.tf','terraform.tfvars','README.md']]+[f'aws-services/{n}/README.md' for n in ['01-iam','02-ec2','03-s3','04-vpc','05-dynamodb-rds']],
        18:['terraform-project/main.tf','terraform-project/README.md'],
        20:[f'final-devops-project/{n}' for n in ['application','docker','kubernetes','helm','terraform','.github/workflows','security','monitoring','gitops','README.md']],
    }
    for a in meta:
        d = ROOT/a['folder'];number = a['number']
        for name in ['README.md','REQUIREMENTS.md']+extra_required.get(number,[]):
            if not (d/name).exists():issues.append(f'{d.name}: missing {name}')
        expected = 'BLOCKED' if number in [15,16,17,18,20] else 'COMPLETE'
        if a['status'] != expected:issues.append(f'{d.name}: status not reconciled with recorded gaps')
        records = [p.name for p in (d/'evidence').glob('*.txt') if 'Exit status: 0' in p.read_text(errors='replace')]
        if not records:issues.append(f'{d.name}: no successful recorded execution')
        images = list((d/'screenshots').glob('*.png'))
        if not images:issues.append(f'{d.name}: screenshot evidence missing')
        readme = (d/'README.md').read_text() if (d/'README.md').exists() else ''
        for p in images:
            if f'(screenshots/{p.name})' not in readme:issues.append(f'{d.name}: screenshot not embedded: {p.name}')
        checks.append(dict(assignment=number,session=a['session'],status=a['status'],successful_records=records,screenshots=len(images)))
    files = [p for p in ROOT.rglob('*') if p.is_file() and not any(x in SKIP for x in p.relative_to(ROOT).parts)]
    link_targets = []
    for p in files:
        rel=str(p.relative_to(ROOT))
        if p.suffix=='.png':
            counts['png_images']+=1
            if Image:
                try:
                    with Image.open(p) as im:im.verify()
                except Exception as ex:issues.append(f'{rel}: invalid PNG: {ex}')
            continue
        if p.suffix in ['.bundle','.pyc']:continue
        data=p.read_text(errors='replace')
        if p.suffix=='.md':
            outside=[];fence=False
            for line in data.splitlines():
                if line.startswith('```'):fence=not fence;continue
                if not fence:outside.append(line)
            for u in re.findall(r'!?\[[^\]]*\]\(([^)]+)\)','\n'.join(outside)):
                if u.startswith(('http:','https:','mailto:','#')):continue
                target=unquote(u.split('#',1)[0].split(' "',1)[0].strip('<>'))
                if not target:continue
                counts['markdown_links']+=1
                candidate=(p.parent/target).resolve()
                if not candidate.exists():issues.append(f'{rel}: broken link: {u}')
                elif candidate.is_file():
                    try:link_targets.append((rel,str(candidate.relative_to(ROOT))))
                    except ValueError:pass
        if p.suffix in ['.yaml','.yml'] and '/templates/' not in rel and yaml:
            try:list(yaml.safe_load_all(data));counts['yaml_files']+=1
            except yaml.YAMLError as ex:issues.append(f'{rel}: YAML parse: {ex}')
        if p.suffix=='.json':
            try:json.loads(data)
            except json.JSONDecodeError as ex:issues.append(f'{rel}: JSON parse: {ex}')
        if p.suffix=='.py':
            try:ast.parse(data);counts['python_files']+=1
            except SyntaxError as ex:issues.append(f'{rel}: Python parse: {ex}')
        if p.suffix=='.sh' or p.name.endswith('.sh.tftpl'):
            result=subprocess.run(['bash','-n',str(p)],capture_output=True,text=True);counts['bash_files']+=1
            if result.returncode:issues.append(f'{rel}: Bash syntax: {result.stderr.strip()}')
        if re.search(r'AKIA[0-9A-Z]{16}|-----BEGIN (?:OPENSSH |RSA |EC )?PRIVATE KEY-----|^set-cookie:',data,re.I|re.M):
            issues.append(f'{rel}: potential credential material; inspect privately')
    # Ignore rules must not make a required linked document disappear from publication.
    if (ROOT/'.git').exists() and link_targets:
        proc=subprocess.run(['git','-C',str(ROOT),'check-ignore','--no-index','--stdin'],input='\n'.join(target for _,target in link_targets)+'\n',capture_output=True,text=True)
        if proc.returncode not in [0,1]:issues.append('Could not verify Git ignore rules')
        ignored=set(proc.stdout.splitlines())
        for source,target in link_targets:
            if target in ignored:issues.append(f'{source}: linked file ignored by Git: {target}')
    actionlint=shutil.which('actionlint')
    if not actionlint:
        p=ROOT.parent/'.local-tools/bin/actionlint'
        if p.is_file():actionlint=str(p)
    workflows=list((ROOT/'.github/workflows').glob('*.yml'))
    workflow_status='unavailable'
    if actionlint:
        result=subprocess.run([actionlint,'-shellcheck=',*[str(p) for p in workflows]],capture_output=True,text=True)
        workflow_status='passed' if result.returncode==0 else 'failed'
        if result.returncode:issues.append('Root workflow validation: '+result.stdout+result.stderr)
    report=dict(reviewed_at=datetime.datetime.now().astimezone().isoformat(),mode='static-source-and-retained-evidence-review',assignment_folders=len(dirs),session_mapping_correct=not any('assignment' in x.lower() for x in issues),locally_complete=sum(a['status']=='COMPLETE' for a in meta),assignments_with_required_gaps=[a['number'] for a in meta if a['status']=='BLOCKED'],checks=counts,yaml_validation='performed' if yaml else 'PyYAML unavailable',image_validation='performed' if Image else 'Pillow unavailable',root_workflows=len(workflows),workflow_lint=workflow_status,assignments=checks,issues=issues)
    if args.write_report:(ROOT/'AUDIT.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps({k:v for k,v in report.items() if k!='assignments'},indent=2))
    return bool(issues)

if __name__=='__main__':
    raise SystemExit(main())
