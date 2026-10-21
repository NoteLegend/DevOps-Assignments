"""Local educational GitOps controller: reconcile Git main every five seconds."""
from pathlib import Path
import subprocess, time
repo = Path(__file__).resolve().parent/'desired'
while True:
    rev = subprocess.check_output(['git','-C',str(repo),'rev-parse','main'],text=True).strip()
    desired = subprocess.check_output(['git','-C',str(repo),'show','main:deployment.yaml'],text=True)
    result = subprocess.run(['kubectl','-n','a19','apply','-f','-'],input=desired,text=True,capture_output=True)
    print(f'commit={rev} exit={result.returncode} {result.stdout.strip()} {result.stderr.strip()}',flush=True)
    time.sleep(5)
