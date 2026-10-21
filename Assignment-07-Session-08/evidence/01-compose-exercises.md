# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
runtime_env=/workspace/.local-tools/runtime/mysql.env
for demo in basic compose-app demo; do
 if [[ "$demo" == demo ]]; then compose_file=demo/docker-compose.yml; else compose_file="$demo/compose.yaml"; fi
 project="devops-a07-$demo"
 docker compose --env-file "$runtime_env" -p "$project" -f "$compose_file" config -q
 docker compose --env-file "$runtime_env" -p "$project" -f "$compose_file" up -d --build
 for attempt in {1..60}; do if curl -fsS http://127.0.0.1:8081 > "evidence/$demo-response.html"; then break; fi; sleep 2; done
 if [[ "$demo" == demo ]]; then
  for attempt in {1..60}; do if curl -fsS http://127.0.0.1:8081/api > evidence/api.json; then break; fi; sleep 2; done
  grep -q 'Hello from MySQL' evidence/api.json
  /tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 02-three-tier-app --url http://127.0.0.1:8081
  docker compose --env-file "$runtime_env" -p "$project" -f "$compose_file" exec -T backend python -c 'import socket; print("database DNS:",socket.gethostbyname("database"))'
 fi
 docker compose --env-file "$runtime_env" -p "$project" -f "$compose_file" ps
 docker volume ls --filter label=com.docker.compose.project="$project"
 docker compose --env-file "$runtime_env" -p "$project" -f "$compose_file" down -v
done

```

```text
Executed 2026-10-07T13:25:56.868337+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-07-Session-08
Script: verify-compose.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ export DEVOPS_WORKSPACE=/home/rushixd/Wurk/Scaler/DevOps
++ DEVOPS_WORKSPACE=/home/rushixd/Wurk/Scaler/DevOps
++ export PATH=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/bin:/home/rushixd/Wurk/Scaler/DevOps/.local-tools/bin:/home/rushixd/.codex/packages/app-server-daemon/releases/0.160.1-x86_64-unknown-linux-musl/codex-path:/home/rushixd/.codex/tmp/arg0/codex-arg0XEF9Mq:/home/rushixd/.codex/packages/app-server-daemon/releases/0.160.1-x86_64-unknown-linux-musl/codex-path:/home/rushixd/.codex/tmp/arg0/codex-arg0x3FaAZ:/home/rushixd/.local/npm/lib/node_modules/@openai/codex/node_modules/@openai/codex-linux-x64/vendor/x86_64-unknown-linux-musl/codex-path:/home/rushixd/.local/npm/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
++ PATH=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/bin:/home/rushixd/Wurk/Scaler/DevOps/.local-tools/bin:/home/rushixd/.codex/packages/app-server-daemon/releases/0.160.1-x86_64-unknown-linux-musl/codex-path:/home/rushixd/.codex/tmp/arg0/codex-arg0XEF9Mq:/home/rushixd/.codex/packages/app-server-daemon/releases/0.160.1-x86_64-unknown-linux-musl/codex-path:/home/rushixd/.codex/tmp/arg0/codex-arg0x3FaAZ:/home/rushixd/.local/npm/lib/node_modules/@openai/codex/node_modules/@openai/codex-linux-x64/vendor/x86_64-unknown-linux-musl/codex-path:/home/rushixd/.local/npm/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
++ export MINIKUBE_HOME=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/minikube
++ MINIKUBE_HOME=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/minikube
++ export KUBECONFIG=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/kubeconfig
++ KUBECONFIG=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/kubeconfig
+ runtime_env=/workspace/.local-tools/runtime/mysql.env
+ for demo in basic compose-app demo
+ [[ basic == demo ]]
+ compose_file=basic/compose.yaml
+ project=devops-a07-basic
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-basic -f basic/compose.yaml config -q
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-basic -f basic/compose.yaml up -d --build
 backend Pulling 
 frontend Pulling 
 f7e1db57b58b Pulling fs layer 
 1efc53192927 Pulling fs layer 
 04bdbc7ea6b5 Pulling fs layer 
 8020170dc65f Pulling fs layer 
 947d22046304 Pulling fs layer 
 ecc510c1e359 Pulling fs layer 
 807ab930f3a0 Pulling fs layer 
 807ab930f3a0 Downloading [==================================================>]     627B/627B
 807ab930f3a0 Downloading [==================================================>]     627B/627B
 f7e1db57b58b Pulling fs layer 
 947d22046304 Pulling fs layer 
 ecc510c1e359 Pulling fs layer 
 8020170dc65f Pulling fs layer 
 1efc53192927 Pulling fs layer 
 807ab930f3a0 Pulling fs layer 
 04bdbc7ea6b5 Pulling fs layer 
 807ab930f3a0 Download complete 
 04bdbc7ea6b5 Downloading [=>                                                 ]  1.049MB/34MB
 04bdbc7ea6b5 Downloading [=>                                                 ]  1.049MB/34MB
 807ab930f3a0 Download complete 
 04bdbc7ea6b5 Downloading [===>                                               ]  2.097MB/34MB
 04bdbc7ea6b5 Downloading [===>                                               ]  2.097MB/34MB
 04bdbc7ea6b5 Downloading [====>                                              ]  3.146MB/34MB
 04bdbc7ea6b5 Downloading [====>                                              ]  3.146MB/34MB
 8020170dc65f Download complete 
 04bdbc7ea6b5 Downloading [====>                                              ]  3.146MB/34MB
 947d22046304 Downloading [==================================================>]     404B/404B
 8020170dc65f Download complete 
 f7e1db57b58b Downloading [==================================================>]    1.4kB/1.4kB
 947d22046304 Downloading [==================================================>]     404B/404B
 04bdbc7ea6b5 Downloading [======>                                            ]  4.194MB/34MB
 f7e1db57b58b Downloading [==================================================>]    1.4kB/1.4kB
 947d22046304 Download complete 
 04bdbc7ea6b5 Downloading [=======>                                           ]  5.243MB/34MB
 947d22046304 Download complete 
 04bdbc7ea6b5 Downloading [=======>                                           ]  5.243MB/34MB
 1efc53192927 Downloading [==================================================>]     955B/955B
 04bdbc7ea6b5 Downloading [=======>                                           ]  5.284MB/34MB
 f7e1db57b58b Download complete 
 f7e1db57b58b Download complete 
 1efc53192927 Downloading [==================================================>]     955B/955B
 04bdbc7ea6b5 Downloading [=========>                                         ]  6.291MB/34MB
 1efc53192927 Downloading [==================================================>]     955B/955B
 04bdbc7ea6b5 Downloading [=========>                                         ]  6.291MB/34MB
 1efc53192927 Downloading [==================================================>]     955B/955B
 04bdbc7ea6b5 Downloading [=========>                                         ]  6.291MB/34MB
 04bdbc7ea6b5 Downloading [==========>                                        ]   7.34MB/34MB
 04bdbc7ea6b5 Downloading [==========>                                        ]   7.34MB/34MB
 04bdbc7ea6b5 Downloading [==========>                                        ]   7.34MB/34MB
 1efc53192927 Download complete 
 1efc53192927 Download complete 
 04bdbc7ea6b5 Downloading [==========>                                        ]   7.34MB/34MB
 04bdbc7ea6b5 Downloading [============>                                      ]  8.389MB/34MB
 04bdbc7ea6b5 Downloading [============>                                      ]  8.389MB/34MB
 04bdbc7ea6b5 Downloading [=============>                                     ]  9.437MB/34MB
 04bdbc7ea6b5 Downloading [=============>                                     ]  9.437MB/34MB
 ecc510c1e359 Downloading [=>                                                 ]  1.049MB/29.84MB
 04bdbc7ea6b5 Downloading [===============>                                   ]  10.49MB/34MB
 ecc510c1e359 Downloading [=>                                                 ]  1.049MB/29.84MB
 04bdbc7ea6b5 Downloading [===============>                                   ]  10.49MB/34MB
 ecc510c1e359 Downloading [=>                                                 ]  1.049MB/29.84MB
 04bdbc7ea6b5 Downloading [===============>                                   ]  10.49MB/34MB
 ecc510c1e359 Downloading [=>                                                 ]  1.049MB/29.84MB
 04bdbc7ea6b5 Downloading [===============>                                   ]  10.49MB/34MB
 ecc510c1e359 Downloading [=>                                                 ]  1.049MB/29.84MB
 04bdbc7ea6b5 Downloading [================>                                  ]  11.53MB/34MB
 a1b85ab28c90 Download complete 
 ecc510c1e359 Downloading [=>                                                 ]  1.049MB/29.84MB
 04bdbc7ea6b5 Downloading [================>                                  ]  11.53MB/34MB
 04bdbc7ea6b5 Downloading [================>                                  ]  11.53MB/34MB
 ecc510c1e359 Downloading [=>                                                 ]  1.049MB/29.84MB
 ecc510c1e359 Downloading [=>                                                 ]  1.049MB/29.84MB
 04bdbc7ea6b5 Downloading [================>                                  ]  11.53MB/34MB
 04bdbc7ea6b5 Downloading [================>                                  ]  11.53MB/34MB
 ecc510c1e359 Downloading [=>                                                 ]  1.049MB/29.84MB
 04bdbc7ea6b5 Downloading [==================>                                ]  12.58MB/34MB
 ecc510c1e359 Downloading [=>                                                 ]  1.049MB/29.84MB
 04bdbc7ea6b5 Downloading [==================>                                ]  12.58MB/34MB
 ecc510c1e359 Downloading [===>                                               ]  2.097MB/29.84MB
 04bdbc7ea6b5 Downloading [==================>                                ]  12.58MB/34MB
 ecc510c1e359 Downloading [===>                                               ]  2.097MB/29.84MB
 04bdbc7ea6b5 Downloading [====================>                              ]  13.63MB/34MB
 ecc510c1e359 Downloading [===>                                               ]  2.097MB/29.84MB
 04bdbc7ea6b5 Downloading [====================>                              ]  13.63MB/34MB
 ecc510c1e359 Downloading [===>                                               ]  2.097MB/29.84MB
 ecc510c1e359 Downloading [===>                                               ]  2.097MB/29.84MB
 04bdbc7ea6b5 Downloading [====================>                              ]  13.63MB/34MB
 ecc510c1e359 Downloading [===>                                               ]  2.097MB/29.84MB
 04bdbc7ea6b5 Downloading [====================>                              ]  13.63MB/34MB
 ecc510c1e359 Downloading [===>                                               ]  2.097MB/29.84MB
 04bdbc7ea6b5 Downloading [====================>                              ]  13.63MB/34MB
 04bdbc7ea6b5 Downloading [====================>                              ]  13.63MB/34MB
 ecc510c1e359 Downloading [===>                                               ]  2.097MB/29.84MB
 ecc510c1e359 Downloading [===>                                               ]  2.097MB/29.84MB
 04bdbc7ea6b5 Downloading [=====================>                             ]  14.68MB/34MB
 ecc510c1e359 Downloading [===>                                               ]  2.097MB/29.84MB
 04bdbc7ea6b5 Downloading [=====================>                             ]  14.68MB/34MB
 04bdbc7ea6b5 Downloading [=====================>                             ]  14.68MB/34MB
 ecc510c1e359 Downloading [===>                                               ]  2.097MB/29.84MB
 ecc510c1e359 Downloading [===>                                               ]  2.097MB/29.84MB
 04bdbc7ea6b5 Downloading [=====================>                             ]  14.68MB/34MB
 ecc510c1e359 Downloading [===>                                               ]  2.097MB/29.84MB
 04bdbc7ea6b5 Downloading [=====================>                             ]  14.68MB/34MB
 ecc510c1e359 Downloading [=====>                                             ]  3.146MB/29.84MB
 04bdbc7ea6b5 Downloading [=====================>                             ]  14.68MB/34MB
 ecc510c1e359 Downloading [=====>                                             ]  3.146MB/29.84MB
 04bdbc7ea6b5 Downloading [=======================>                           ]  15.73MB/34MB
 04bdbc7ea6b5 Downloading [=======================>                           ]  15.73MB/34MB
 c329293b1d90 Downloading [==================>                                ]  1.049MB/2.824MB
 ecc510c1e359 Downloading [=====>                                             ]  3.146MB/29.84MB
 04bdbc7ea6b5 Downloading [=======================>                           ]  15.73MB/34MB
 ecc510c1e359 Downloading [=====>                                             ]  3.146MB/29.84MB
 04bdbc7ea6b5 Downloading [=======================>                           ]  15.73MB/34MB
 c329293b1d90 Downloading [==================>                                ]  1.049MB/2.824MB
 ecc510c1e359 Downloading [=====>                                             ]  3.146MB/29.84MB
 ecc510c1e359 Downloading [=====>                                             ]  3.146MB/29.84MB
 04bdbc7ea6b5 Downloading [========================>                          ]  16.78MB/34MB
 ecc510c1e359 Downloading [=====>                                             ]  3.146MB/29.84MB
 04bdbc7ea6b5 Downloading [========================>                          ]  16.78MB/34MB
 c329293b1d90 Downloading [==================>                                ]  1.049MB/2.824MB
 ecc510c1e359 Downloading [=======>                                           ]  4.194MB/29.84MB
 04bdbc7ea6b5 Downloading [========================>                          ]  16.78MB/34MB
 ecc510c1e359 Downloading [=======>                                           ]  4.194MB/29.84MB
 04bdbc7ea6b5 Downloading [========================>                          ]  16.78MB/34MB
 c329293b1d90 Downloading [==================>                                ]  1.049MB/2.824MB
 ecc510c1e359 Downloading [=======>                                           ]  4.194MB/29.84MB
 04bdbc7ea6b5 Downloading [==========================>                        ]  17.83MB/34MB
 ecc510c1e359 Downloading [=======>                                           ]  4.194MB/29.84MB
 04bdbc7ea6b5 Downloading [==========================>                        ]  17.83MB/34MB
 c329293b1d90 Downloading [==================>                                ]  1.049MB/2.824MB
 04bdbc7ea6b5 Downloading [==========================>                        ]  17.83MB/34MB
 ecc510c1e359 Downloading [=======>                                           ]  4.194MB/29.84MB
 ecc510c1e359 Downloading [=======>                                           ]  4.194MB/29.84MB
 04bdbc7ea6b5 Downloading [==========================>                        ]  17.83MB/34MB
 c329293b1d90 Downloading [=====================================>             ]  2.097MB/2.824MB
 04bdbc7ea6b5 Downloading [==========================>                        ]  17.83MB/34MB
 ecc510c1e359 Downloading [=======>                                           ]  4.194MB/29.84MB
 ecc510c1e359 Downloading [=======>                                           ]  4.194MB/29.84MB
 04bdbc7ea6b5 Downloading [===========================>                       ]  18.87MB/34MB
 c329293b1d90 Downloading [=====================================>             ]  2.097MB/2.824MB
 ecc510c1e359 Downloading [========>                                          ]  5.243MB/29.84MB
 04bdbc7ea6b5 Downloading [===========================>                       ]  18.87MB/34MB
 04bdbc7ea6b5 Downloading [===========================>                       ]  18.87MB/34MB
 c329293b1d90 Downloading [=====================================>             ]  2.097MB/2.824MB
 ecc510c1e359 Downloading [========>                                          ]  5.243MB/29.84MB
 04bdbc7ea6b5 Downloading [===========================>                       ]  18.87MB/34MB
 a1b85ab28c90 Download complete 
 c329293b1d90 Downloading [=====================================>             ]  2.097MB/2.824MB
 ecc510c1e359 Downloading [========>                                          ]  5.243MB/29.84MB
 ecc510c1e359 Downloading [========>                                          ]  5.243MB/29.84MB
 04bdbc7ea6b5 Downloading [===========================>                       ]  18.87MB/34MB
 c329293b1d90 Downloading [=====================================>             ]  2.097MB/2.824MB
 04bdbc7ea6b5 Downloading [=============================>                     ]  19.92MB/34MB
 c329293b1d90 Download complete 
 ecc510c1e359 Downloading [========>                                          ]  5.243MB/29.84MB
 ecc510c1e359 Downloading [========>                                          ]  5.243MB/29.84MB
 04bdbc7ea6b5 Downloading [=============================>                     ]  19.92MB/34MB
 c329293b1d90 Download complete 
 04bdbc7ea6b5 Downloading [=============================>                     ]  19.92MB/34MB
 ecc510c1e359 Downloading [========>                                          ]  5.243MB/29.84MB
 04bdbc7ea6b5 Downloading [=============================>                     ]  19.92MB/34MB
 ecc510c1e359 Downloading [========>                                          ]  5.243MB/29.84MB
 04bdbc7ea6b5 Downloading [=============================>                     ]  19.92MB/34MB
 ecc510c1e359 Downloading [========>                                          ]  5.243MB/29.84MB
 ecc510c1e359 Downloading [========>                                          ]  5.243MB/29.84MB
 04bdbc7ea6b5 Downloading [=============================>                     ]  20.05MB/34MB
 ecc510c1e359 Downloading [==========>                                        ]  6.291MB/29.84MB
 04bdbc7ea6b5 Downloading [==============================>                    ]  20.97MB/34MB
 04bdbc7ea6b5 Downloading [==============================>                    ]  20.97MB/34MB
 ecc510c1e359 Downloading [==========>                                        ]  6.291MB/29.84MB
 04bdbc7ea6b5 Downloading [==============================>                    ]  20.97MB/34MB
 ecc510c1e359 Downloading [==========>                                        ]  6.291MB/29.84MB
 ecc510c1e359 Downloading [==========>                                        ]  6.291MB/29.84MB
 04bdbc7ea6b5 Downloading [==============================>                    ]  20.97MB/34MB
 ecc510c1e359 Downloading [==========>                                        ]  6.291MB/29.84MB
 04bdbc7ea6b5 Downloading [================================>                  ]  22.02MB/34MB
 04bdbc7ea6b5 Downloading [================================>                  ]  22.02MB/34MB
 ecc510c1e359 Downloading [==========>                                        ]  6.291MB/29.84MB
 ecc510c1e359 Downloading [==========>                                        ]  6.291MB/29.84MB
 04bdbc7ea6b5 Downloading [================================>                  ]  22.02MB/34MB
 ecc510c1e359 Downloading [==========>                                        ]  6.291MB/29.84MB
 04bdbc7ea6b5 Downloading [================================>                  ]  22.02MB/34MB
 04bdbc7ea6b5 Downloading [================================>                  ]  22.02MB/34MB
 ecc510c1e359 Downloading [============>                                      ]   7.34MB/29.84MB
 ecc510c1e359 Downloading [============>                                      ]   7.34MB/29.84MB
 04bdbc7ea6b5 Downloading [=================================>                 ]  23.07MB/34MB
 04bdbc7ea6b5 Downloading [=================================>                 ]  23.07MB/34MB
 ecc510c1e359 Downloading [============>                                      ]   7.34MB/29.84MB
 ecc510c1e359 Downloading [============>                                      ]   7.34MB/29.84MB
 04bdbc7ea6b5 Downloading [=================================>                 ]  23.07MB/34MB
 ecc510c1e359 Downloading [============>                                      ]   7.34MB/29.84MB
 04bdbc7ea6b5 Downloading [=================================>                 ]  23.07MB/34MB
 04bdbc7ea6b5 Downloading [=================================>                 ]  23.07MB/34MB
 ecc510c1e359 Downloading [============>                                      ]   7.34MB/29.84MB
 04bdbc7ea6b5 Downloading [===================================>               ]  24.12MB/34MB
 ecc510c1e359 Downloading [============>                                      ]   7.34MB/29.84MB
 ecc510c1e359 Downloading [============>                                      ]   7.34MB/29.84MB
 04bdbc7ea6b5 Downloading [===================================>               ]  24.12MB/34MB
 ecc510c1e359 Downloading [==============>                                    ]  8.389MB/29.84MB
 04bdbc7ea6b5 Downloading [===================================>               ]  24.12MB/34MB
 ecc510c1e359 Downloading [==============>                                    ]  8.389MB/29.84MB
 04bdbc7ea6b5 Downloading [===================================>               ]  24.12MB/34MB
 ecc510c1e359 Downloading [==============>                                    ]  8.389MB/29.84MB
 04bdbc7ea6b5 Downloading [=====================================>             ]  25.17MB/34MB
 ecc510c1e359 Downloading [==============>                                    ]  8.389MB/29.84MB
 04bdbc7ea6b5 Downloading [=====================================>             ]  25.17MB/34MB
 ecc510c1e359 Downloading [==============>                                    ]  8.389MB/29.84MB
 04bdbc7ea6b5 Downloading [======================================>            ]  26.21MB/34MB
 ecc510c1e359 Downloading [==============>                                    ]  8.389MB/29.84MB
 04bdbc7ea6b5 Downloading [======================================>            ]  26.21MB/34MB
 ecc510c1e359 Downloading [==============>                                    ]  8.389MB/29.84MB
 04bdbc7ea6b5 Downloading [======================================>            ]  26.21MB/34MB
 ecc510c1e359 Downloading [==============>                                    ]  8.389MB/29.84MB
 04bdbc7ea6b5 Downloading [======================================>            ]  26.21MB/34MB
 ecc510c1e359 Downloading [===============>                                   ]  9.437MB/29.84MB
 04bdbc7ea6b5 Downloading [========================================>          ]  27.26MB/34MB
 ecc510c1e359 Downloading [===============>                                   ]  9.437MB/29.84MB
 04bdbc7ea6b5 Downloading [========================================>          ]  27.26MB/34MB
 ecc510c1e359 Downloading [===============>                                   ]  9.437MB/29.84MB
 04bdbc7ea6b5 Downloading [========================================>          ]  27.26MB/34MB
 ecc510c1e359 Downloading [===============>                                   ]  9.437MB/29.84MB
 04bdbc7ea6b5 Downloading [========================================>          ]  27.26MB/34MB
 ecc510c1e359 Downloading [===============>                                   ]  9.437MB/29.84MB
 04bdbc7ea6b5 Downloading [=========================================>         ]  28.31MB/34MB
 ecc510c1e359 Downloading [===============>                                   ]  9.437MB/29.84MB
 04bdbc7ea6b5 Downloading [=========================================>         ]  28.31MB/34MB
 04bdbc7ea6b5 Downloading [=========================================>         ]  28.31MB/34MB
 ecc510c1e359 Downloading [=================>                                 ]  10.49MB/29.84MB
 ecc510c1e359 Downloading [=================>                                 ]  10.49MB/29.84MB
 04bdbc7ea6b5 Downloading [=========================================>         ]  28.31MB/34MB
 04bdbc7ea6b5 Downloading [===========================================>       ]  29.36MB/34MB
 ecc510c1e359 Downloading [=================>                                 ]  10.49MB/29.84MB
 ecc510c1e359 Downloading [=================>                                 ]  10.49MB/29.84MB
 04bdbc7ea6b5 Downloading [===========================================>       ]  29.36MB/34MB
 04bdbc7ea6b5 Downloading [===========================================>       ]  29.36MB/34MB
 ecc510c1e359 Downloading [=================>                                 ]  10.49MB/29.84MB
 ecc510c1e359 Downloading [=================>                                 ]  10.49MB/29.84MB
 04bdbc7ea6b5 Downloading [===========================================>       ]  29.36MB/34MB
 ecc510c1e359 Downloading [=================>                                 ]  10.49MB/29.84MB
 04bdbc7ea6b5 Downloading [============================================>      ]  30.41MB/34MB
 ecc510c1e359 Downloading [=================>                                 ]  10.49MB/29.84MB
 04bdbc7ea6b5 Downloading [============================================>      ]  30.41MB/34MB
 ecc510c1e359 Downloading [==================>                                ]  10.77MB/29.84MB
 04bdbc7ea6b5 Downloading [============================================>      ]  30.41MB/34MB
 04bdbc7ea6b5 Downloading [============================================>      ]  30.41MB/34MB
 ecc510c1e359 Downloading [===================>                               ]  11.53MB/29.84MB
 04bdbc7ea6b5 Downloading [============================================>      ]  30.41MB/34MB
 ecc510c1e359 Downloading [===================>                               ]  11.53MB/29.84MB
 ecc510c1e359 Downloading [===================>                               ]  11.53MB/29.84MB
 04bdbc7ea6b5 Downloading [============================================>      ]  30.41MB/34MB
 ecc510c1e359 Downloading [===================>                               ]  11.53MB/29.84MB
 04bdbc7ea6b5 Downloading [==============================================>    ]  31.46MB/34MB
 04bdbc7ea6b5 Downloading [==============================================>    ]  31.46MB/34MB
 ecc510c1e359 Downloading [===================>                               ]  11.53MB/29.84MB
 ecc510c1e359 Downloading [===================>                               ]  11.53MB/29.84MB
 04bdbc7ea6b5 Downloading [==============================================>    ]  31.46MB/34MB
 04bdbc7ea6b5 Downloading [==============================================>    ]  31.46MB/34MB
 ecc510c1e359 Downloading [===================>                               ]  11.53MB/29.84MB
 04bdbc7ea6b5 Downloading [===============================================>   ]  32.51MB/34MB
 ecc510c1e359 Downloading [===================>                               ]  11.53MB/29.84MB
 ecc510c1e359 Downloading [===================>                               ]  11.53MB/29.84MB
 04bdbc7ea6b5 Downloading [===============================================>   ]  32.51MB/34MB
 ecc510c1e359 Downloading [=====================>                             ]  12.58MB/29.84MB
 04bdbc7ea6b5 Downloading [===============================================>   ]  32.51MB/34MB
 ecc510c1e359 Downloading [=====================>                             ]  12.58MB/29.84MB
 04bdbc7ea6b5 Downloading [===============================================>   ]  32.51MB/34MB
 ecc510c1e359 Downloading [=====================>                             ]  12.58MB/29.84MB
 04bdbc7ea6b5 Downloading [=================================================> ]  33.55MB/34MB
 ecc510c1e359 Downloading [=====================>                             ]  12.58MB/29.84MB
 04bdbc7ea6b5 Downloading [=================================================> ]  33.55MB/34MB
 ecc510c1e359 Downloading [=====================>                             ]  12.58MB/29.84MB
 04bdbc7ea6b5 Downloading [==================================================>]     34MB/34MB
 ecc510c1e359 Downloading [=====================>                             ]  12.58MB/29.84MB
 04bdbc7ea6b5 Downloading [==================================================>]     34MB/34MB
 ecc510c1e359 Downloading [======================>                            ]  13.63MB/29.84MB
 04bdbc7ea6b5 Download complete 
 ecc510c1e359 Downloading [======================>                            ]  13.63MB/29.84MB
 04bdbc7ea6b5 Download complete 
 ecc510c1e359 Downloading [======================>                            ]  13.63MB/29.84MB
 ecc510c1e359 Downloading [======================>                            ]  13.63MB/29.84MB
 ecc510c1e359 Downloading [======================>                            ]  13.63MB/29.84MB
 ecc510c1e359 Downloading [======================>                            ]  13.63MB/29.84MB
 ecc510c1e359 Downloading [========================>                          ]  14.68MB/29.84MB
 ecc510c1e359 Downloading [========================>                          ]  14.68MB/29.84MB
 ecc510c1e359 Downloading [========================>                          ]  14.68MB/29.84MB
 ecc510c1e359 Downloading [========================>                          ]  14.68MB/29.84MB
 ecc510c1e359 Downloading [========================>                          ]  14.68MB/29.84MB
 ecc510c1e359 Downloading [========================>                          ]  14.68MB/29.84MB
 ecc510c1e359 Downloading [==========================>                        ]  15.73MB/29.84MB
 ecc510c1e359 Downloading [==========================>                        ]  15.73MB/29.84MB
 ecc510c1e359 Downloading [============================>                      ]  16.78MB/29.84MB
 ecc510c1e359 Downloading [============================>                      ]  16.78MB/29.84MB
 ecc510c1e359 Downloading [============================>                      ]  16.78MB/29.84MB
 ecc510c1e359 Downloading [============================>                      ]  16.78MB/29.84MB
 ecc510c1e359 Downloading [=============================>                     ]  17.83MB/29.84MB
 ecc510c1e359 Downloading [=============================>                     ]  17.83MB/29.84MB
 ecc510c1e359 Downloading [===============================>                   ]  18.87MB/29.84MB
 ecc510c1e359 Downloading [===============================>                   ]  18.87MB/29.84MB
 ecc510c1e359 Downloading [=================================>                 ]  19.92MB/29.84MB
 ecc510c1e359 Downloading [=================================>                 ]  19.92MB/29.84MB
 ecc510c1e359 Downloading [===================================>               ]  20.97MB/29.84MB
 ecc510c1e359 Downloading [===================================>               ]  20.97MB/29.84MB
 ecc510c1e359 Downloading [====================================>              ]  22.02MB/29.84MB
 ecc510c1e359 Downloading [====================================>              ]  22.02MB/29.84MB
 ecc510c1e359 Downloading [======================================>            ]  23.07MB/29.84MB
 ecc510c1e359 Downloading [======================================>            ]  23.07MB/29.84MB
 ecc510c1e359 Downloading [======================================>            ]  23.07MB/29.84MB
 ecc510c1e359 Downloading [========================================>          ]  24.12MB/29.84MB
 ecc510c1e359 Downloading [========================================>          ]  24.12MB/29.84MB
 ecc510c1e359 Downloading [========================================>          ]  24.12MB/29.84MB
 ecc510c1e359 Downloading [==========================================>        ]  25.17MB/29.84MB
 ecc510c1e359 Downloading [==========================================>        ]  25.17MB/29.84MB
 ecc510c1e359 Downloading [==========================================>        ]  25.17MB/29.84MB
 ecc510c1e359 Downloading [===========================================>       ]  26.21MB/29.84MB
 ecc510c1e359 Downloading [=============================================>     ]  27.26MB/29.84MB
 ecc510c1e359 Downloading [=============================================>     ]  27.26MB/29.84MB
 ecc510c1e359 Downloading [===============================================>   ]  28.31MB/29.84MB
 ecc510c1e359 Downloading [===============================================>   ]  28.31MB/29.84MB
 ecc510c1e359 Downloading [===============================================>   ]  28.31MB/29.84MB
 ecc510c1e359 Downloading [===============================================>   ]  28.31MB/29.84MB
 ecc510c1e359 Downloading [=================================================> ]  29.36MB/29.84MB
 ecc510c1e359 Downloading [=================================================> ]  29.36MB/29.84MB
 ecc510c1e359 Downloading [==================================================>]  29.84MB/29.84MB
 ecc510c1e359 Download complete 
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Download complete 
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 1 s
 ecc510c1e359 Extracting 2 s
 ecc510c1e359 Pull complete 
 ecc510c1e359 Pull complete 
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Extracting 1 s
 04bdbc7ea6b5 Pull complete 
 04bdbc7ea6b5 Pull complete 
 807ab930f3a0 Pull complete 
 807ab930f3a0 Pull complete 
 1efc53192927 Pull complete 
 1efc53192927 Pull complete 
 947d22046304 Extracting 1 s
 947d22046304 Pull complete 
 947d22046304 Pull complete 
 8020170dc65f Extracting 1 s
 8020170dc65f Pull complete 
 8020170dc65f Pull complete 
 f7e1db57b58b Extracting 1 s
 f7e1db57b58b Pull complete 
 f7e1db57b58b Pull complete 
 backend Pulled 
 frontend Pulled 
 Network devops-a07-basic_default  Creating
 Network devops-a07-basic_default  Created
 Volume devops-a07-basic_db_data  Creating
 Volume devops-a07-basic_db_data  Created
 Container devops-a07-basic-frontend-1  Creating
 Container devops-a07-basic-database-1  Creating
 Container devops-a07-basic-backend-1  Creating
 Container devops-a07-basic-frontend-1  Created
 Container devops-a07-basic-database-1  Created
 Container devops-a07-basic-backend-1  Created
 Container devops-a07-basic-frontend-1  Starting
 Container devops-a07-basic-backend-1  Starting
 Container devops-a07-basic-database-1  Starting
 Container devops-a07-basic-frontend-1  Started
 Container devops-a07-basic-backend-1  Started
 Container devops-a07-basic-database-1  Started
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
+ break
+ [[ basic == demo ]]
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-basic -f basic/compose.yaml ps
NAME                          IMAGE       COMMAND                  SERVICE    CREATED         STATUS                  PORTS
devops-a07-basic-backend-1    nginx       "/docker-entrypoint.…"   backend    2 seconds ago   Up Less than a second   80/tcp
devops-a07-basic-database-1   mysql:8.0   "docker-entrypoint.s…"   database   2 seconds ago   Up Less than a second   3306/tcp, 33060/tcp
devops-a07-basic-frontend-1   nginx       "/docker-entrypoint.…"   frontend   2 seconds ago   Up 1 second             0.0.0.0:8081->80/tcp, [::]:8081->80/tcp
+ docker volume ls --filter label=com.docker.compose.project=devops-a07-basic
DRIVER    VOLUME NAME
local     devops-a07-basic_db_data
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-basic -f basic/compose.yaml down -v
 Container devops-a07-basic-frontend-1  Stopping
 Container devops-a07-basic-backend-1  Stopping
 Container devops-a07-basic-database-1  Stopping
 Container devops-a07-basic-backend-1  Stopped
 Container devops-a07-basic-backend-1  Removing
 Container devops-a07-basic-frontend-1  Stopped
 Container devops-a07-basic-frontend-1  Removing
 Container devops-a07-basic-backend-1  Removed
 Container devops-a07-basic-frontend-1  Removed
 Container devops-a07-basic-database-1  Stopped
 Container devops-a07-basic-database-1  Removing
 Container devops-a07-basic-database-1  Removed
 Volume devops-a07-basic_db_data  Removing
 Network devops-a07-basic_default  Removing
 Volume devops-a07-basic_db_data  Removed
 Network devops-a07-basic_default  Removed
+ for demo in basic compose-app demo
+ [[ compose-app == demo ]]
+ compose_file=compose-app/compose.yaml
+ project=devops-a07-compose-app
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-compose-app -f compose-app/compose.yaml config -q
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-compose-app -f compose-app/compose.yaml up -d --build
 database Pulling 
 6bdafce1e6fb Pulling fs layer 
 343c451c026a Pulling fs layer 
 a95bd78f8620 Pulling fs layer 
 0da02031b810 Pulling fs layer 
 330a9fb3841e Pulling fs layer 
 1441bc0931d1 Pulling fs layer 
 f37786bee968 Pulling fs layer 
 a67ddc05b7f8 Pulling fs layer 
 661f04f054c4 Pulling fs layer 
 20b7464ce26b Pulling fs layer 
 20b7464ce26b Downloading [==================================================>]  2.604kB/2.604kB
 6bdafce1e6fb Downloading [==================================================>]  5.228kB/5.228kB
 20b7464ce26b Downloading [==================================================>]  2.604kB/2.604kB
 a95bd78f8620 Downloading [==================================================>]     324B/324B
 6bdafce1e6fb Downloading [==================================================>]  5.228kB/5.228kB
 20b7464ce26b Downloading [==================================================>]  2.604kB/2.604kB
 20b7464ce26b Downloading [==================================================>]  2.604kB/2.604kB
 343c451c026a Downloading [==================================================>]     340B/340B
 a95bd78f8620 Downloading [==================================================>]     324B/324B
 6bdafce1e6fb Downloading [==================================================>]  5.228kB/5.228kB
 6bdafce1e6fb Downloading [==================================================>]  5.228kB/5.228kB
 343c451c026a Downloading [==================================================>]     340B/340B
 a95bd78f8620 Downloading [==================================================>]     324B/324B
 343c451c026a Downloading [==================================================>]     340B/340B
 a95bd78f8620 Download complete 
 6bdafce1e6fb Download complete 
 20b7464ce26b Download complete 
 343c451c026a Download complete 
 a67ddc05b7f8 Downloading [================>                                  ]  2.097MB/6.198MB
 661f04f054c4 Downloading [==================================================>]     883B/883B
 a67ddc05b7f8 Downloading [================>                                  ]  2.097MB/6.198MB
 661f04f054c4 Download complete 
 a67ddc05b7f8 Downloading [=========================>                         ]  3.146MB/6.198MB
 a67ddc05b7f8 Downloading [=========================>                         ]  3.146MB/6.198MB
 a67ddc05b7f8 Downloading [=========================>                         ]  3.146MB/6.198MB
 a67ddc05b7f8 Downloading [=========================>                         ]  3.146MB/6.198MB
 a67ddc05b7f8 Downloading [=================================>                 ]  4.194MB/6.198MB
 330a9fb3841e Downloading [>                                                  ]  1.049MB/57.45MB
 330a9fb3841e Downloading [>                                                  ]  1.049MB/57.45MB
 a67ddc05b7f8 Downloading [==========================================>        ]  5.243MB/6.198MB
 330a9fb3841e Downloading [>                                                  ]  1.049MB/57.45MB
 a67ddc05b7f8 Downloading [==========================================>        ]  5.243MB/6.198MB
 330a9fb3841e Downloading [>                                                  ]  1.049MB/57.45MB
 a67ddc05b7f8 Downloading [==================================================>]  6.198MB/6.198MB
 330a9fb3841e Downloading [=>                                                 ]  2.097MB/57.45MB
 a67ddc05b7f8 Download complete 
 0da02031b810 Downloading [=>                                                 ]  1.049MB/47.94MB
 330a9fb3841e Downloading [=>                                                 ]  2.097MB/57.45MB
 1441bc0931d1 Download complete 
 330a9fb3841e Downloading [=>                                                 ]  2.097MB/57.45MB
 0da02031b810 Downloading [=>                                                 ]  1.049MB/47.94MB
 f37786bee968 Downloading [>                                                  ]  1.049MB/160MB
 0da02031b810 Downloading [=>                                                 ]  1.049MB/47.94MB
 330a9fb3841e Downloading [==>                                                ]  3.146MB/57.45MB
 330a9fb3841e Downloading [==>                                                ]  3.146MB/57.45MB
 f37786bee968 Downloading [>                                                  ]  1.049MB/160MB
 0da02031b810 Downloading [=>                                                 ]  1.049MB/47.94MB
 f37786bee968 Downloading [>                                                  ]  1.049MB/160MB
 0da02031b810 Downloading [=>                                                 ]  1.049MB/47.94MB
 330a9fb3841e Downloading [==>                                                ]  3.146MB/57.45MB
 330a9fb3841e Downloading [==>                                                ]  3.146MB/57.45MB
 c462e963975f Download complete 
 f37786bee968 Downloading [>                                                  ]  1.049MB/160MB
 0da02031b810 Downloading [=>                                                 ]  1.049MB/47.94MB
 f37786bee968 Downloading [>                                                  ]  1.049MB/160MB
 0da02031b810 Downloading [==>                                                ]  2.097MB/47.94MB
 330a9fb3841e Downloading [===>                                               ]  4.194MB/57.45MB
 330a9fb3841e Downloading [===>                                               ]  4.194MB/57.45MB
 f37786bee968 Downloading [>                                                  ]  1.049MB/160MB
 0da02031b810 Downloading [==>                                                ]  2.097MB/47.94MB
 f37786bee968 Downloading [>                                                  ]  1.049MB/160MB
 0da02031b810 Downloading [==>                                                ]  2.097MB/47.94MB
 330a9fb3841e Downloading [====>                                              ]  5.243MB/57.45MB
 330a9fb3841e Downloading [====>                                              ]  5.243MB/57.45MB
 f37786bee968 Downloading [>                                                  ]  1.049MB/160MB
 0da02031b810 Downloading [==>                                                ]  2.097MB/47.94MB
 330a9fb3841e Downloading [=====>                                             ]  6.291MB/57.45MB
 f37786bee968 Downloading [>                                                  ]  2.097MB/160MB
 0da02031b810 Downloading [===>                                               ]  3.146MB/47.94MB
 f37786bee968 Downloading [>                                                  ]  2.097MB/160MB
 0da02031b810 Downloading [===>                                               ]  3.146MB/47.94MB
 330a9fb3841e Downloading [=====>                                             ]  6.291MB/57.45MB
 f37786bee968 Downloading [>                                                  ]  2.097MB/160MB
 0da02031b810 Downloading [===>                                               ]  3.146MB/47.94MB
 330a9fb3841e Downloading [=====>                                             ]  6.291MB/57.45MB
 f37786bee968 Downloading [>                                                  ]  2.097MB/160MB
 0da02031b810 Downloading [===>                                               ]  3.146MB/47.94MB
 330a9fb3841e Downloading [======>                                            ]   7.34MB/57.45MB
 330a9fb3841e Downloading [======>                                            ]   7.34MB/57.45MB
 f37786bee968 Downloading [>                                                  ]  2.097MB/160MB
 0da02031b810 Downloading [===>                                               ]  3.146MB/47.94MB
 f37786bee968 Downloading [>                                                  ]  2.097MB/160MB
 0da02031b810 Downloading [====>                                              ]  4.194MB/47.94MB
 330a9fb3841e Downloading [======>                                            ]   7.34MB/57.45MB
 330a9fb3841e Downloading [=======>                                           ]  8.389MB/57.45MB
 f37786bee968 Downloading [>                                                  ]  2.097MB/160MB
 0da02031b810 Downloading [====>                                              ]  4.194MB/47.94MB
 330a9fb3841e Downloading [=======>                                           ]  8.389MB/57.45MB
 f37786bee968 Downloading [>                                                  ]  3.146MB/160MB
 0da02031b810 Downloading [====>                                              ]  4.194MB/47.94MB
 f37786bee968 Downloading [>                                                  ]  3.146MB/160MB
 0da02031b810 Downloading [====>                                              ]  4.194MB/47.94MB
 330a9fb3841e Downloading [=======>                                           ]  8.389MB/57.45MB
 0da02031b810 Downloading [====>                                              ]  4.194MB/47.94MB
 330a9fb3841e Downloading [========>                                          ]  9.437MB/57.45MB
 5a27b49a98e1 Downloading [===>                                               ]  1.049MB/17.42MB
 f37786bee968 Downloading [>                                                  ]  3.146MB/160MB
 330a9fb3841e Downloading [========>                                          ]  9.437MB/57.45MB
 5a27b49a98e1 Downloading [===>                                               ]  1.049MB/17.42MB
 f37786bee968 Downloading [>                                                  ]  3.146MB/160MB
 0da02031b810 Downloading [=====>                                             ]  5.243MB/47.94MB
 330a9fb3841e Downloading [========>                                          ]  9.437MB/57.45MB
 5a27b49a98e1 Downloading [===>                                               ]  1.049MB/17.42MB
 f37786bee968 Downloading [>                                                  ]  3.146MB/160MB
 0da02031b810 Downloading [=====>                                             ]  5.243MB/47.94MB
 5a27b49a98e1 Downloading [===>                                               ]  1.049MB/17.42MB
 f37786bee968 Downloading [>                                                  ]  3.146MB/160MB
 0da02031b810 Downloading [=====>                                             ]  5.243MB/47.94MB
 330a9fb3841e Downloading [=========>                                         ]  10.49MB/57.45MB
 5a27b49a98e1 Downloading [===>                                               ]  1.049MB/17.42MB
 f37786bee968 Downloading [>                                                  ]  3.146MB/160MB
 0da02031b810 Downloading [=====>                                             ]  5.243MB/47.94MB
 330a9fb3841e Downloading [=========>                                         ]  10.49MB/57.45MB
 5a27b49a98e1 Downloading [===>                                               ]  1.049MB/17.42MB
 f37786bee968 Downloading [>                                                  ]  3.146MB/160MB
 0da02031b810 Downloading [=====>                                             ]  5.243MB/47.94MB
 330a9fb3841e Downloading [=========>                                         ]  10.49MB/57.45MB
 0da02031b810 Downloading [======>                                            ]  6.291MB/47.94MB
 330a9fb3841e Downloading [==========>                                        ]  11.53MB/57.45MB
 5a27b49a98e1 Downloading [======>                                            ]  2.097MB/17.42MB
 f37786bee968 Downloading [>                                                  ]  3.146MB/160MB
 5a27b49a98e1 Downloading [======>                                            ]  2.097MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  4.194MB/160MB
 0da02031b810 Downloading [======>                                            ]  6.291MB/47.94MB
 330a9fb3841e Downloading [==========>                                        ]  11.53MB/57.45MB
 5a27b49a98e1 Downloading [======>                                            ]  2.097MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  4.194MB/160MB
 0da02031b810 Downloading [======>                                            ]  6.291MB/47.94MB
 330a9fb3841e Downloading [==========>                                        ]  11.53MB/57.45MB
 f37786bee968 Downloading [=>                                                 ]  4.194MB/160MB
 0da02031b810 Downloading [======>                                            ]  6.291MB/47.94MB
 330a9fb3841e Downloading [==========>                                        ]  12.58MB/57.45MB
 5a27b49a98e1 Downloading [======>                                            ]  2.097MB/17.42MB
 330a9fb3841e Downloading [==========>                                        ]  12.58MB/57.45MB
 5a27b49a98e1 Downloading [======>                                            ]  2.097MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  4.194MB/160MB
 0da02031b810 Downloading [======>                                            ]  6.291MB/47.94MB
 330a9fb3841e Downloading [==========>                                        ]  12.58MB/57.45MB
 5a27b49a98e1 Downloading [======>                                            ]  2.097MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  4.194MB/160MB
 0da02031b810 Downloading [======>                                            ]  6.291MB/47.94MB
 330a9fb3841e Downloading [==========>                                        ]  12.58MB/57.45MB
 5a27b49a98e1 Downloading [======>                                            ]  2.097MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  4.194MB/160MB
 0da02031b810 Downloading [=======>                                           ]   7.34MB/47.94MB
 330a9fb3841e Downloading [===========>                                       ]  13.63MB/57.45MB
 5a27b49a98e1 Downloading [=========>                                         ]  3.146MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  4.194MB/160MB
 0da02031b810 Downloading [=======>                                           ]   7.34MB/47.94MB
 330a9fb3841e Downloading [===========>                                       ]  13.63MB/57.45MB
 5a27b49a98e1 Downloading [=========>                                         ]  3.146MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  4.194MB/160MB
 0da02031b810 Downloading [=======>                                           ]   7.34MB/47.94MB
 5a27b49a98e1 Downloading [=========>                                         ]  3.146MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  4.194MB/160MB
 0da02031b810 Downloading [=======>                                           ]   7.34MB/47.94MB
 330a9fb3841e Downloading [===========>                                       ]  13.63MB/57.45MB
 5a27b49a98e1 Downloading [=========>                                         ]  3.146MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  4.194MB/160MB
 0da02031b810 Downloading [=======>                                           ]   7.34MB/47.94MB
 330a9fb3841e Downloading [===========>                                       ]  13.63MB/57.45MB
 330a9fb3841e Downloading [============>                                      ]  14.68MB/57.45MB
 5a27b49a98e1 Downloading [=========>                                         ]  3.146MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  5.243MB/160MB
 0da02031b810 Downloading [=======>                                           ]   7.34MB/47.94MB
 5a27b49a98e1 Downloading [=========>                                         ]  3.146MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  5.243MB/160MB
 0da02031b810 Downloading [=======>                                           ]   7.34MB/47.94MB
 330a9fb3841e Downloading [============>                                      ]  14.68MB/57.45MB
 5a27b49a98e1 Downloading [=========>                                         ]  3.146MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  5.243MB/160MB
 0da02031b810 Downloading [========>                                          ]  8.389MB/47.94MB
 330a9fb3841e Downloading [============>                                      ]  14.68MB/57.45MB
 5a27b49a98e1 Downloading [============>                                      ]  4.194MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  5.243MB/160MB
 0da02031b810 Downloading [========>                                          ]  8.389MB/47.94MB
 330a9fb3841e Downloading [============>                                      ]  14.68MB/57.45MB
 0da02031b810 Downloading [========>                                          ]  8.389MB/47.94MB
 330a9fb3841e Downloading [=============>                                     ]  15.73MB/57.45MB
 5a27b49a98e1 Downloading [============>                                      ]  4.194MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  5.243MB/160MB
 5a27b49a98e1 Downloading [============>                                      ]  4.194MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  5.243MB/160MB
 0da02031b810 Downloading [========>                                          ]  8.389MB/47.94MB
 330a9fb3841e Downloading [=============>                                     ]  15.73MB/57.45MB
 330a9fb3841e Downloading [=============>                                     ]  15.73MB/57.45MB
 5a27b49a98e1 Downloading [============>                                      ]  4.194MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  5.243MB/160MB
 0da02031b810 Downloading [========>                                          ]  8.389MB/47.94MB
 5a27b49a98e1 Downloading [============>                                      ]  4.194MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  5.243MB/160MB
 0da02031b810 Downloading [=========>                                         ]  9.437MB/47.94MB
 330a9fb3841e Downloading [==============>                                    ]  16.78MB/57.45MB
 5a27b49a98e1 Downloading [============>                                      ]  4.194MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  5.243MB/160MB
 0da02031b810 Downloading [=========>                                         ]  9.437MB/47.94MB
 330a9fb3841e Downloading [==============>                                    ]  16.78MB/57.45MB
 330a9fb3841e Downloading [==============>                                    ]  16.78MB/57.45MB
 5a27b49a98e1 Downloading [===============>                                   ]  5.243MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  5.243MB/160MB
 0da02031b810 Downloading [=========>                                         ]  9.437MB/47.94MB
 5a27b49a98e1 Downloading [===============>                                   ]  5.243MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  5.243MB/160MB
 0da02031b810 Downloading [=========>                                         ]  9.437MB/47.94MB
 330a9fb3841e Downloading [==============>                                    ]  16.78MB/57.45MB
 330a9fb3841e Downloading [===============>                                   ]  17.83MB/57.45MB
 5a27b49a98e1 Downloading [===============>                                   ]  5.243MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  6.291MB/160MB
 0da02031b810 Downloading [=========>                                         ]  9.437MB/47.94MB
 330a9fb3841e Downloading [===============>                                   ]  17.83MB/57.45MB
 5a27b49a98e1 Downloading [===============>                                   ]  5.243MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  6.291MB/160MB
 0da02031b810 Downloading [==========>                                        ]  10.49MB/47.94MB
 f37786bee968 Downloading [=>                                                 ]  6.291MB/160MB
 0da02031b810 Downloading [==========>                                        ]  10.49MB/47.94MB
 330a9fb3841e Downloading [================>                                  ]  18.87MB/57.45MB
 5a27b49a98e1 Downloading [===============>                                   ]  5.243MB/17.42MB
 5a27b49a98e1 Downloading [==================>                                ]  6.291MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  6.291MB/160MB
 0da02031b810 Downloading [==========>                                        ]  10.49MB/47.94MB
 330a9fb3841e Downloading [================>                                  ]  18.87MB/57.45MB
 330a9fb3841e Downloading [================>                                  ]  18.87MB/57.45MB
 5a27b49a98e1 Downloading [==================>                                ]  6.291MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  6.291MB/160MB
 0da02031b810 Downloading [==========>                                        ]  10.49MB/47.94MB
 330a9fb3841e Downloading [=================>                                 ]  19.92MB/57.45MB
 5a27b49a98e1 Downloading [==================>                                ]  6.291MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  6.291MB/160MB
 0da02031b810 Downloading [==========>                                        ]  10.49MB/47.94MB
 330a9fb3841e Downloading [=================>                                 ]  19.92MB/57.45MB
 5a27b49a98e1 Downloading [==================>                                ]  6.291MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  6.291MB/160MB
 0da02031b810 Downloading [==========>                                        ]  10.49MB/47.94MB
 5a27b49a98e1 Downloading [==================>                                ]  6.291MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  6.291MB/160MB
 0da02031b810 Downloading [==========>                                        ]  10.49MB/47.94MB
 330a9fb3841e Downloading [=================>                                 ]  19.92MB/57.45MB
 330a9fb3841e Downloading [=================>                                 ]  19.92MB/57.45MB
 5a27b49a98e1 Downloading [=====================>                             ]   7.34MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  6.291MB/160MB
 0da02031b810 Downloading [==========>                                        ]  10.49MB/47.94MB
 330a9fb3841e Downloading [==================>                                ]  20.97MB/57.45MB
 5a27b49a98e1 Downloading [=====================>                             ]   7.34MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  6.291MB/160MB
 0da02031b810 Downloading [==========>                                        ]  10.49MB/47.94MB
 330a9fb3841e Downloading [==================>                                ]  20.97MB/57.45MB
 5a27b49a98e1 Downloading [=====================>                             ]   7.34MB/17.42MB
 f37786bee968 Downloading [=>                                                 ]  6.291MB/160MB
 0da02031b810 Downloading [============>                                      ]  11.53MB/47.94MB
 5a27b49a98e1 Downloading [=====================>                             ]   7.34MB/17.42MB
 f37786bee968 Downloading [==>                                                ]   7.34MB/160MB
 0da02031b810 Downloading [============>                                      ]  11.53MB/47.94MB
 330a9fb3841e Downloading [==================>                                ]  20.97MB/57.45MB
 330a9fb3841e Downloading [===================>                               ]  22.02MB/57.45MB
 5a27b49a98e1 Downloading [=====================>                             ]   7.34MB/17.42MB
 f37786bee968 Downloading [==>                                                ]   7.34MB/160MB
 0da02031b810 Downloading [============>                                      ]  11.53MB/47.94MB
 5a27b49a98e1 Downloading [========================>                          ]  8.389MB/17.42MB
 f37786bee968 Downloading [==>                                                ]   7.34MB/160MB
 0da02031b810 Downloading [============>                                      ]  11.53MB/47.94MB
 330a9fb3841e Downloading [===================>                               ]  22.02MB/57.45MB
 330a9fb3841e Downloading [===================>                               ]  22.02MB/57.45MB
 5a27b49a98e1 Downloading [========================>                          ]  8.389MB/17.42MB
 f37786bee968 Downloading [==>                                                ]   7.34MB/160MB
 0da02031b810 Downloading [============>                                      ]  11.53MB/47.94MB
 5a27b49a98e1 Downloading [========================>                          ]  8.389MB/17.42MB
 f37786bee968 Downloading [==>                                                ]   7.34MB/160MB
 0da02031b810 Downloading [=============>                                     ]  12.58MB/47.94MB
 330a9fb3841e Downloading [====================>                              ]  23.07MB/57.45MB
 5a27b49a98e1 Downloading [========================>                          ]  8.389MB/17.42MB
 f37786bee968 Downloading [==>                                                ]   7.34MB/160MB
 0da02031b810 Downloading [=============>                                     ]  12.58MB/47.94MB
 330a9fb3841e Downloading [====================>                              ]  23.07MB/57.45MB
 330a9fb3841e Downloading [====================>                              ]  23.07MB/57.45MB
 5a27b49a98e1 Downloading [========================>                          ]  8.389MB/17.42MB
 f37786bee968 Downloading [==>                                                ]   7.34MB/160MB
 0da02031b810 Downloading [=============>                                     ]  12.58MB/47.94MB
 5a27b49a98e1 Downloading [========================>                          ]  8.389MB/17.42MB
 f37786bee968 Downloading [==>                                                ]   7.34MB/160MB
 0da02031b810 Downloading [=============>                                     ]  12.58MB/47.94MB
 330a9fb3841e Downloading [====================>                              ]  23.07MB/57.45MB
 330a9fb3841e Downloading [====================>                              ]  24.12MB/57.45MB
 5a27b49a98e1 Downloading [========================>                          ]  8.389MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  8.389MB/160MB
 0da02031b810 Downloading [=============>                                     ]  12.58MB/47.94MB
 5a27b49a98e1 Downloading [===========================>                       ]  9.437MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  8.389MB/160MB
 0da02031b810 Downloading [==============>                                    ]  13.63MB/47.94MB
 330a9fb3841e Downloading [====================>                              ]  24.12MB/57.45MB
 5a27b49a98e1 Downloading [===========================>                       ]  9.437MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  8.389MB/160MB
 0da02031b810 Downloading [==============>                                    ]  13.63MB/47.94MB
 330a9fb3841e Downloading [====================>                              ]  24.12MB/57.45MB
 330a9fb3841e Downloading [====================>                              ]  24.12MB/57.45MB
 5a27b49a98e1 Downloading [===========================>                       ]  9.437MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  8.389MB/160MB
 0da02031b810 Downloading [==============>                                    ]  13.63MB/47.94MB
 330a9fb3841e Downloading [====================>                              ]  24.12MB/57.45MB
 5a27b49a98e1 Downloading [===========================>                       ]  9.437MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  8.389MB/160MB
 0da02031b810 Downloading [==============>                                    ]  13.63MB/47.94MB
 330a9fb3841e Downloading [====================>                              ]  24.12MB/57.45MB
 5a27b49a98e1 Downloading [===========================>                       ]  9.437MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  8.389MB/160MB
 0da02031b810 Downloading [==============>                                    ]  13.63MB/47.94MB
 5a27b49a98e1 Downloading [===========================>                       ]  9.437MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  8.389MB/160MB
 0da02031b810 Downloading [==============>                                    ]  13.63MB/47.94MB
 330a9fb3841e Downloading [====================>                              ]  24.12MB/57.45MB
 5a27b49a98e1 Downloading [===========================>                       ]  9.437MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  8.389MB/160MB
 0da02031b810 Downloading [===============>                                   ]  14.68MB/47.94MB
 330a9fb3841e Downloading [=====================>                             ]  25.17MB/57.45MB
 5a27b49a98e1 Downloading [===========================>                       ]  9.437MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  8.389MB/160MB
 0da02031b810 Downloading [===============>                                   ]  14.68MB/47.94MB
 330a9fb3841e Downloading [=====================>                             ]  25.17MB/57.45MB
 5a27b49a98e1 Downloading [==============================>                    ]  10.49MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  8.389MB/160MB
 0da02031b810 Downloading [===============>                                   ]  14.68MB/47.94MB
 330a9fb3841e Downloading [=====================>                             ]  25.17MB/57.45MB
 0da02031b810 Downloading [===============>                                   ]  14.68MB/47.94MB
 330a9fb3841e Downloading [=====================>                             ]  25.17MB/57.45MB
 5a27b49a98e1 Downloading [==============================>                    ]  10.49MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  8.389MB/160MB
 5a27b49a98e1 Downloading [==============================>                    ]  10.49MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  9.437MB/160MB
 0da02031b810 Downloading [================>                                  ]  15.73MB/47.94MB
 330a9fb3841e Downloading [======================>                            ]  26.21MB/57.45MB
 5a27b49a98e1 Downloading [==============================>                    ]  10.49MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  9.437MB/160MB
 0da02031b810 Downloading [================>                                  ]  15.73MB/47.94MB
 330a9fb3841e Downloading [======================>                            ]  26.21MB/57.45MB
 0da02031b810 Downloading [================>                                  ]  15.73MB/47.94MB
 330a9fb3841e Downloading [======================>                            ]  26.21MB/57.45MB
 5a27b49a98e1 Downloading [=================================>                 ]  11.53MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  9.437MB/160MB
 5a27b49a98e1 Downloading [=================================>                 ]  11.53MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  9.437MB/160MB
 0da02031b810 Downloading [================>                                  ]  15.73MB/47.94MB
 330a9fb3841e Downloading [======================>                            ]  26.21MB/57.45MB
 330a9fb3841e Downloading [======================>                            ]  26.21MB/57.45MB
 5a27b49a98e1 Downloading [=================================>                 ]  11.53MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  9.437MB/160MB
 0da02031b810 Downloading [================>                                  ]  15.73MB/47.94MB
 5a27b49a98e1 Downloading [=================================>                 ]  11.53MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  9.437MB/160MB
 0da02031b810 Downloading [=================>                                 ]  16.78MB/47.94MB
 330a9fb3841e Downloading [=======================>                           ]  27.26MB/57.45MB
 5a27b49a98e1 Downloading [====================================>              ]  12.58MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  9.437MB/160MB
 0da02031b810 Downloading [=================>                                 ]  16.78MB/47.94MB
 330a9fb3841e Downloading [=======================>                           ]  27.26MB/57.45MB
 5a27b49a98e1 Downloading [====================================>              ]  12.58MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  9.437MB/160MB
 0da02031b810 Downloading [=================>                                 ]  16.78MB/47.94MB
 330a9fb3841e Downloading [=======================>                           ]  27.26MB/57.45MB
 330a9fb3841e Downloading [=======================>                           ]  27.26MB/57.45MB
 5a27b49a98e1 Downloading [====================================>              ]  12.58MB/17.42MB
 f37786bee968 Downloading [==>                                                ]  9.437MB/160MB
 0da02031b810 Downloading [=================>                                 ]  16.78MB/47.94MB
 5a27b49a98e1 Downloading [=======================================>           ]  13.63MB/17.42MB
 f37786bee968 Downloading [===>                                               ]  10.49MB/160MB
 0da02031b810 Downloading [=================>                                 ]  16.78MB/47.94MB
 330a9fb3841e Downloading [========================>                          ]  28.31MB/57.45MB
 5a27b49a98e1 Downloading [=======================================>           ]  13.63MB/17.42MB
 f37786bee968 Downloading [===>                                               ]  10.49MB/160MB
 0da02031b810 Downloading [==================>                                ]  17.83MB/47.94MB
 330a9fb3841e Downloading [========================>                          ]  28.31MB/57.45MB
 330a9fb3841e Downloading [========================>                          ]  28.31MB/57.45MB
 5a27b49a98e1 Downloading [=======================================>           ]  13.63MB/17.42MB
 f37786bee968 Downloading [===>                                               ]  10.49MB/160MB
 0da02031b810 Downloading [==================>                                ]  17.83MB/47.94MB
 5a27b49a98e1 Downloading [=======================================>           ]  13.63MB/17.42MB
 f37786bee968 Downloading [===>                                               ]  10.49MB/160MB
 0da02031b810 Downloading [==================>                                ]  17.83MB/47.94MB
 330a9fb3841e Downloading [========================>                          ]  28.31MB/57.45MB
 f37786bee968 Downloading [===>                                               ]  10.49MB/160MB
 0da02031b810 Downloading [==================>                                ]  17.83MB/47.94MB
 330a9fb3841e Downloading [========================>                          ]  28.31MB/57.45MB
 5a27b49a98e1 Downloading [==========================================>        ]  14.68MB/17.42MB
 330a9fb3841e Downloading [=========================>                         ]  29.36MB/57.45MB
 5a27b49a98e1 Downloading [==========================================>        ]  14.68MB/17.42MB
 f37786bee968 Downloading [===>                                               ]  10.49MB/160MB
 0da02031b810 Downloading [==================>                                ]  17.83MB/47.94MB
 330a9fb3841e Downloading [=========================>                         ]  29.36MB/57.45MB
 5a27b49a98e1 Downloading [==========================================>        ]  14.68MB/17.42MB
 f37786bee968 Downloading [===>                                               ]  10.49MB/160MB
 0da02031b810 Downloading [===================>                               ]  18.87MB/47.94MB
 5a27b49a98e1 Downloading [==========================================>        ]  14.68MB/17.42MB
 f37786bee968 Downloading [===>                                               ]  10.49MB/160MB
 0da02031b810 Downloading [===================>                               ]  18.87MB/47.94MB
 330a9fb3841e Downloading [=========================>                         ]  29.36MB/57.45MB
 f37786bee968 Downloading [===>                                               ]  10.49MB/160MB
 0da02031b810 Downloading [===================>                               ]  18.87MB/47.94MB
 330a9fb3841e Downloading [=========================>                         ]  29.36MB/57.45MB
 5a27b49a98e1 Downloading [=============================================>     ]  15.73MB/17.42MB
 f37786bee968 Downloading [===>                                               ]  10.49MB/160MB
 0da02031b810 Downloading [===================>                               ]  18.87MB/47.94MB
 330a9fb3841e Downloading [=========================>                         ]  29.36MB/57.45MB
 5a27b49a98e1 Downloading [=============================================>     ]  15.73MB/17.42MB
 5a27b49a98e1 Downloading [================================================>  ]  16.78MB/17.42MB
 f37786bee968 Downloading [===>                                               ]  11.53MB/160MB
 0da02031b810 Downloading [===================>                               ]  18.87MB/47.94MB
 330a9fb3841e Downloading [=========================>                         ]  29.36MB/57.45MB
 5a27b49a98e1 Downloading [==================================================>]  17.42MB/17.42MB
 f37786bee968 Downloading [===>                                               ]  11.53MB/160MB
 0da02031b810 Downloading [====================>                              ]  19.92MB/47.94MB
 330a9fb3841e Downloading [==========================>                        ]  30.41MB/57.45MB
 f37786bee968 Downloading [===>                                               ]  11.53MB/160MB
 0da02031b810 Downloading [====================>                              ]  19.92MB/47.94MB
 330a9fb3841e Downloading [==========================>                        ]  30.41MB/57.45MB
 5a27b49a98e1 Download complete 
 f37786bee968 Downloading [===>                                               ]  11.53MB/160MB
 0da02031b810 Downloading [====================>                              ]  19.92MB/47.94MB
 330a9fb3841e Downloading [==========================>                        ]  30.41MB/57.45MB
 330a9fb3841e Downloading [===========================>                       ]  31.46MB/57.45MB
 f37786bee968 Downloading [===>                                               ]  11.53MB/160MB
 0da02031b810 Downloading [====================>                              ]  19.92MB/47.94MB
 330a9fb3841e Downloading [===========================>                       ]  31.46MB/57.45MB
 f37786bee968 Downloading [===>                                               ]  11.53MB/160MB
 0da02031b810 Downloading [=====================>                             ]  20.97MB/47.94MB
 330a9fb3841e Downloading [===========================>                       ]  31.46MB/57.45MB
 f37786bee968 Downloading [===>                                               ]  11.53MB/160MB
 0da02031b810 Downloading [=====================>                             ]  20.97MB/47.94MB
 f37786bee968 Downloading [===>                                               ]  12.58MB/160MB
 0da02031b810 Downloading [=====================>                             ]  20.97MB/47.94MB
 330a9fb3841e Downloading [============================>                      ]  32.51MB/57.45MB
 f37786bee968 Downloading [===>                                               ]  12.58MB/160MB
 0da02031b810 Downloading [=====================>                             ]  20.97MB/47.94MB
 330a9fb3841e Downloading [============================>                      ]  32.51MB/57.45MB
 330a9fb3841e Downloading [=============================>                     ]  33.55MB/57.45MB
 f37786bee968 Downloading [===>                                               ]  12.58MB/160MB
 0da02031b810 Downloading [=====================>                             ]  20.97MB/47.94MB
 f37786bee968 Downloading [===>                                               ]  12.58MB/160MB
 0da02031b810 Downloading [=====================>                             ]  20.97MB/47.94MB
 330a9fb3841e Downloading [=============================>                     ]  33.55MB/57.45MB
 330a9fb3841e Downloading [=============================>                     ]  33.55MB/57.45MB
 f37786bee968 Downloading [===>                                               ]  12.58MB/160MB
 0da02031b810 Downloading [======================>                            ]  22.02MB/47.94MB
 f37786bee968 Downloading [===>                                               ]  12.58MB/160MB
 0da02031b810 Downloading [======================>                            ]  22.02MB/47.94MB
 330a9fb3841e Downloading [==============================>                    ]   34.6MB/57.45MB
 330a9fb3841e Downloading [==============================>                    ]   34.6MB/57.45MB
 f37786bee968 Downloading [====>                                              ]  13.63MB/160MB
 0da02031b810 Downloading [======================>                            ]  22.02MB/47.94MB
 f37786bee968 Downloading [====>                                              ]  13.63MB/160MB
 0da02031b810 Downloading [======================>                            ]  22.02MB/47.94MB
 330a9fb3841e Downloading [===============================>                   ]  35.65MB/57.45MB
 330a9fb3841e Downloading [===============================>                   ]  35.65MB/57.45MB
 f37786bee968 Downloading [====>                                              ]  13.63MB/160MB
 0da02031b810 Downloading [========================>                          ]  23.07MB/47.94MB
 f37786bee968 Downloading [====>                                              ]  13.63MB/160MB
 0da02031b810 Downloading [========================>                          ]  23.07MB/47.94MB
 330a9fb3841e Downloading [===============================>                   ]  35.65MB/57.45MB
 330a9fb3841e Downloading [===============================>                   ]  35.65MB/57.45MB
 f37786bee968 Downloading [====>                                              ]  13.63MB/160MB
 0da02031b810 Downloading [========================>                          ]  23.07MB/47.94MB
 330a9fb3841e Downloading [===============================>                   ]   36.7MB/57.45MB
 f37786bee968 Downloading [====>                                              ]  13.63MB/160MB
 0da02031b810 Downloading [========================>                          ]  23.07MB/47.94MB
 330a9fb3841e Downloading [===============================>                   ]   36.7MB/57.45MB
 f37786bee968 Downloading [====>                                              ]  14.15MB/160MB
 0da02031b810 Downloading [=========================>                         ]  24.12MB/47.94MB
 f37786bee968 Downloading [====>                                              ]  14.68MB/160MB
 0da02031b810 Downloading [=========================>                         ]  24.12MB/47.94MB
 330a9fb3841e Downloading [===============================>                   ]   36.7MB/57.45MB
 330a9fb3841e Downloading [================================>                  ]  37.75MB/57.45MB
 f37786bee968 Downloading [====>                                              ]  14.68MB/160MB
 0da02031b810 Downloading [=========================>                         ]  24.12MB/47.94MB
 f37786bee968 Downloading [====>                                              ]  14.68MB/160MB
 0da02031b810 Downloading [=========================>                         ]  24.12MB/47.94MB
 330a9fb3841e Downloading [================================>                  ]  37.75MB/57.45MB
 330a9fb3841e Downloading [================================>                  ]  37.75MB/57.45MB
 f37786bee968 Downloading [====>                                              ]  14.68MB/160MB
 0da02031b810 Downloading [=========================>                         ]  24.12MB/47.94MB
 f37786bee968 Downloading [====>                                              ]  14.68MB/160MB
 0da02031b810 Downloading [=========================>                         ]  24.12MB/47.94MB
 330a9fb3841e Downloading [================================>                  ]  37.75MB/57.45MB
 f37786bee968 Downloading [====>                                              ]  14.68MB/160MB
 0da02031b810 Downloading [==========================>                        ]  25.17MB/47.94MB
 330a9fb3841e Downloading [================================>                  ]  37.75MB/57.45MB
 330a9fb3841e Downloading [=================================>                 ]   38.8MB/57.45MB
 f37786bee968 Downloading [====>                                              ]  14.68MB/160MB
 0da02031b810 Downloading [==========================>                        ]  25.17MB/47.94MB
 330a9fb3841e Downloading [==================================>                ]  39.85MB/57.45MB
 f37786bee968 Downloading [====>                                              ]  15.73MB/160MB
 0da02031b810 Downloading [===========================>                       ]  26.21MB/47.94MB
 f37786bee968 Downloading [====>                                              ]  15.73MB/160MB
 0da02031b810 Downloading [===========================>                       ]  26.21MB/47.94MB
 330a9fb3841e Downloading [==================================>                ]  39.85MB/57.45MB
 f37786bee968 Downloading [====>                                              ]  15.73MB/160MB
 0da02031b810 Downloading [===========================>                       ]  26.21MB/47.94MB
 330a9fb3841e Downloading [==================================>                ]  39.85MB/57.45MB
 330a9fb3841e Downloading [===================================>               ]  40.89MB/57.45MB
 f37786bee968 Downloading [====>                                              ]  15.73MB/160MB
 0da02031b810 Downloading [============================>                      ]  27.26MB/47.94MB
 f37786bee968 Downloading [====>                                              ]  15.73MB/160MB
 0da02031b810 Downloading [============================>                      ]  27.26MB/47.94MB
 330a9fb3841e Downloading [===================================>               ]  40.89MB/57.45MB
 330a9fb3841e Downloading [====================================>              ]  41.94MB/57.45MB
 f37786bee968 Downloading [=====>                                             ]  16.78MB/160MB
 0da02031b810 Downloading [============================>                      ]  27.26MB/47.94MB
 f37786bee968 Downloading [=====>                                             ]  16.78MB/160MB
 0da02031b810 Downloading [=============================>                     ]  28.31MB/47.94MB
 330a9fb3841e Downloading [====================================>              ]  41.94MB/57.45MB
 f37786bee968 Downloading [=====>                                             ]  16.78MB/160MB
 0da02031b810 Downloading [=============================>                     ]  28.31MB/47.94MB
 330a9fb3841e Downloading [====================================>              ]  41.94MB/57.45MB
 f37786bee968 Downloading [=====>                                             ]  16.78MB/160MB
 0da02031b810 Downloading [=============================>                     ]  28.31MB/47.94MB
 330a9fb3841e Downloading [====================================>              ]  41.94MB/57.45MB
 330a9fb3841e Downloading [=====================================>             ]  42.99MB/57.45MB
 f37786bee968 Downloading [=====>                                             ]  16.78MB/160MB
 0da02031b810 Downloading [=============================>                     ]  28.31MB/47.94MB
 f37786bee968 Downloading [=====>                                             ]  16.78MB/160MB
 0da02031b810 Downloading [==============================>                    ]  29.36MB/47.94MB
 330a9fb3841e Downloading [=====================================>             ]  42.99MB/57.45MB
 330a9fb3841e Downloading [=====================================>             ]  42.99MB/57.45MB
 f37786bee968 Downloading [=====>                                             ]  17.83MB/160MB
 0da02031b810 Downloading [==============================>                    ]  29.36MB/47.94MB
 330a9fb3841e Downloading [======================================>            ]  44.04MB/57.45MB
 f37786bee968 Downloading [=====>                                             ]  17.83MB/160MB
 0da02031b810 Downloading [==============================>                    ]  29.36MB/47.94MB
 330a9fb3841e Downloading [======================================>            ]  44.04MB/57.45MB
 f37786bee968 Downloading [=====>                                             ]  17.83MB/160MB
 0da02031b810 Downloading [===============================>                   ]  30.41MB/47.94MB
 0da02031b810 Downloading [===============================>                   ]  30.41MB/47.94MB
 330a9fb3841e Downloading [=======================================>           ]  45.09MB/57.45MB
 f37786bee968 Downloading [=====>                                             ]  17.83MB/160MB
 f37786bee968 Downloading [=====>                                             ]  17.83MB/160MB
 0da02031b810 Downloading [===============================>                   ]  30.41MB/47.94MB
 330a9fb3841e Downloading [=======================================>           ]  45.09MB/57.45MB
 330a9fb3841e Downloading [=======================================>           ]  45.09MB/57.45MB
 f37786bee968 Downloading [=====>                                             ]  18.87MB/160MB
 0da02031b810 Downloading [================================>                  ]  31.46MB/47.94MB
 f37786bee968 Downloading [=====>                                             ]  18.87MB/160MB
 0da02031b810 Downloading [================================>                  ]  31.46MB/47.94MB
 330a9fb3841e Downloading [=======================================>           ]  45.09MB/57.45MB
 330a9fb3841e Downloading [=======================================>           ]  45.09MB/57.45MB
 f37786bee968 Downloading [=====>                                             ]  18.87MB/160MB
 0da02031b810 Downloading [================================>                  ]  31.46MB/47.94MB
 330a9fb3841e Downloading [========================================>          ]  46.14MB/57.45MB
 f37786bee968 Downloading [=====>                                             ]  18.87MB/160MB
 0da02031b810 Downloading [================================>                  ]  31.46MB/47.94MB
 330a9fb3841e Downloading [========================================>          ]  46.14MB/57.45MB
 f37786bee968 Downloading [=====>                                             ]  18.87MB/160MB
 0da02031b810 Downloading [=================================>                 ]  32.51MB/47.94MB
 f37786bee968 Downloading [=====>                                             ]  18.87MB/160MB
 0da02031b810 Downloading [=================================>                 ]  32.51MB/47.94MB
 330a9fb3841e Downloading [========================================>          ]  46.14MB/57.45MB
 330a9fb3841e Downloading [=========================================>         ]  47.19MB/57.45MB
 f37786bee968 Downloading [=====>                                             ]  18.87MB/160MB
 0da02031b810 Downloading [==================================>                ]  33.55MB/47.94MB
 f37786bee968 Downloading [======>                                            ]  19.92MB/160MB
 0da02031b810 Downloading [==================================>                ]  33.55MB/47.94MB
 330a9fb3841e Downloading [=========================================>         ]  47.19MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  19.92MB/160MB
 0da02031b810 Downloading [==================================>                ]  33.55MB/47.94MB
 330a9fb3841e Downloading [=========================================>         ]  47.19MB/57.45MB
 330a9fb3841e Downloading [=========================================>         ]  47.19MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  19.92MB/160MB
 0da02031b810 Downloading [====================================>              ]   34.6MB/47.94MB
 f37786bee968 Downloading [======>                                            ]  19.92MB/160MB
 0da02031b810 Downloading [====================================>              ]   34.6MB/47.94MB
 330a9fb3841e Downloading [=========================================>         ]  47.19MB/57.45MB
 330a9fb3841e Downloading [=========================================>         ]  48.23MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  19.92MB/160MB
 0da02031b810 Downloading [====================================>              ]   34.6MB/47.94MB
 f37786bee968 Downloading [======>                                            ]  19.92MB/160MB
 0da02031b810 Downloading [=====================================>             ]  35.65MB/47.94MB
 330a9fb3841e Downloading [=========================================>         ]  48.23MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  19.92MB/160MB
 0da02031b810 Downloading [=====================================>             ]  35.65MB/47.94MB
 330a9fb3841e Downloading [=========================================>         ]  48.23MB/57.45MB
 330a9fb3841e Downloading [=========================================>         ]  48.23MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  19.92MB/160MB
 0da02031b810 Downloading [=====================================>             ]  35.65MB/47.94MB
 f37786bee968 Downloading [======>                                            ]  19.92MB/160MB
 0da02031b810 Downloading [=====================================>             ]  35.65MB/47.94MB
 330a9fb3841e Downloading [=========================================>         ]  48.23MB/57.45MB
 0da02031b810 Downloading [=====================================>             ]  35.65MB/47.94MB
 330a9fb3841e Downloading [=========================================>         ]  48.23MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  19.92MB/160MB
 f37786bee968 Downloading [======>                                            ]  20.97MB/160MB
 0da02031b810 Downloading [======================================>            ]   36.7MB/47.94MB
 330a9fb3841e Downloading [==========================================>        ]  49.28MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  20.97MB/160MB
 0da02031b810 Downloading [======================================>            ]   36.7MB/47.94MB
 330a9fb3841e Downloading [==========================================>        ]  49.28MB/57.45MB
 0da02031b810 Downloading [======================================>            ]   36.7MB/47.94MB
 330a9fb3841e Downloading [==========================================>        ]  49.28MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  20.97MB/160MB
 f37786bee968 Downloading [======>                                            ]  20.97MB/160MB
 0da02031b810 Downloading [=======================================>           ]  37.75MB/47.94MB
 330a9fb3841e Downloading [===========================================>       ]  50.33MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  20.97MB/160MB
 0da02031b810 Downloading [=======================================>           ]  37.75MB/47.94MB
 330a9fb3841e Downloading [===========================================>       ]  50.33MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  20.97MB/160MB
 0da02031b810 Downloading [=======================================>           ]  37.75MB/47.94MB
 330a9fb3841e Downloading [===========================================>       ]  50.33MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  22.02MB/160MB
 0da02031b810 Downloading [========================================>          ]   38.8MB/47.94MB
 330a9fb3841e Downloading [============================================>      ]  51.38MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  22.02MB/160MB
 0da02031b810 Downloading [========================================>          ]   38.8MB/47.94MB
 330a9fb3841e Downloading [============================================>      ]  51.38MB/57.45MB
 330a9fb3841e Downloading [============================================>      ]  51.38MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  22.02MB/160MB
 0da02031b810 Downloading [========================================>          ]   38.8MB/47.94MB
 0da02031b810 Downloading [=========================================>         ]  39.85MB/47.94MB
 330a9fb3841e Downloading [============================================>      ]  51.38MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  22.02MB/160MB
 f37786bee968 Downloading [======>                                            ]  22.02MB/160MB
 0da02031b810 Downloading [=========================================>         ]  39.85MB/47.94MB
 330a9fb3841e Downloading [=============================================>     ]  52.43MB/57.45MB
 f37786bee968 Downloading [======>                                            ]  22.02MB/160MB
 0da02031b810 Downloading [=========================================>         ]  39.85MB/47.94MB
 330a9fb3841e Downloading [=============================================>     ]  52.43MB/57.45MB
 330a9fb3841e Downloading [=============================================>     ]  52.43MB/57.45MB
 f37786bee968 Downloading [=======>                                           ]  23.07MB/160MB
 0da02031b810 Downloading [==========================================>        ]  40.89MB/47.94MB
 330a9fb3841e Downloading [==============================================>    ]  53.48MB/57.45MB
 f37786bee968 Downloading [=======>                                           ]  23.07MB/160MB
 0da02031b810 Downloading [==========================================>        ]  40.89MB/47.94MB
 f37786bee968 Downloading [=======>                                           ]  23.07MB/160MB
 0da02031b810 Downloading [==========================================>        ]  40.89MB/47.94MB
 330a9fb3841e Downloading [==============================================>    ]  53.48MB/57.45MB
 f37786bee968 Downloading [=======>                                           ]  23.07MB/160MB
 0da02031b810 Downloading [==========================================>        ]  40.89MB/47.94MB
 330a9fb3841e Downloading [==============================================>    ]  53.48MB/57.45MB
 f37786bee968 Downloading [=======>                                           ]  23.07MB/160MB
 0da02031b810 Downloading [===========================================>       ]  41.94MB/47.94MB
 330a9fb3841e Downloading [==============================================>    ]  53.48MB/57.45MB
 330a9fb3841e Downloading [===============================================>   ]  54.53MB/57.45MB
 f37786bee968 Downloading [=======>                                           ]  23.07MB/160MB
 0da02031b810 Downloading [===========================================>       ]  41.94MB/47.94MB
 0da02031b810 Downloading [===========================================>       ]  41.94MB/47.94MB
 330a9fb3841e Downloading [===============================================>   ]  54.53MB/57.45MB
 f37786bee968 Downloading [=======>                                           ]  24.12MB/160MB
 330a9fb3841e Downloading [===============================================>   ]  54.53MB/57.45MB
 f37786bee968 Downloading [=======>                                           ]  24.12MB/160MB
 0da02031b810 Downloading [============================================>      ]  42.99MB/47.94MB
 f37786bee968 Downloading [=======>                                           ]  24.12MB/160MB
 0da02031b810 Downloading [============================================>      ]  42.99MB/47.94MB
 330a9fb3841e Downloading [================================================>  ]  55.57MB/57.45MB
 330a9fb3841e Downloading [================================================>  ]  55.57MB/57.45MB
 f37786bee968 Downloading [=======>                                           ]  24.12MB/160MB
 0da02031b810 Downloading [============================================>      ]  42.99MB/47.94MB
 330a9fb3841e Downloading [================================================>  ]  55.57MB/57.45MB
 f37786bee968 Downloading [=======>                                           ]  24.12MB/160MB
 0da02031b810 Downloading [=============================================>     ]  44.04MB/47.94MB
 f37786bee968 Downloading [=======>                                           ]  24.12MB/160MB
 0da02031b810 Downloading [=============================================>     ]  44.04MB/47.94MB
 330a9fb3841e Downloading [=================================================> ]  56.62MB/57.45MB
 f37786bee968 Downloading [=======>                                           ]  25.17MB/160MB
 0da02031b810 Downloading [=============================================>     ]  44.04MB/47.94MB
 330a9fb3841e Downloading [=================================================> ]  56.62MB/57.45MB
 330a9fb3841e Downloading [==================================================>]  57.45MB/57.45MB
 f37786bee968 Downloading [=======>                                           ]  25.17MB/160MB
 0da02031b810 Downloading [===============================================>   ]  45.09MB/47.94MB
 f37786bee968 Downloading [=======>                                           ]  25.17MB/160MB
 0da02031b810 Downloading [===============================================>   ]  45.09MB/47.94MB
 330a9fb3841e Download complete 
 f37786bee968 Downloading [========>                                          ]  26.21MB/160MB
 0da02031b810 Downloading [===============================================>   ]  45.09MB/47.94MB
 f37786bee968 Downloading [========>                                          ]  26.21MB/160MB
 0da02031b810 Downloading [================================================>  ]  46.14MB/47.94MB
 f37786bee968 Downloading [========>                                          ]  26.21MB/160MB
 0da02031b810 Downloading [================================================>  ]  46.14MB/47.94MB
 f37786bee968 Downloading [========>                                          ]  26.21MB/160MB
 0da02031b810 Downloading [================================================>  ]  46.14MB/47.94MB
 f37786bee968 Downloading [========>                                          ]  26.21MB/160MB
 0da02031b810 Downloading [=================================================> ]  47.19MB/47.94MB
 f37786bee968 Downloading [========>                                          ]  27.26MB/160MB
 0da02031b810 Downloading [=================================================> ]  47.19MB/47.94MB
 f37786bee968 Downloading [========>                                          ]  27.26MB/160MB
 0da02031b810 Downloading [==================================================>]  47.94MB/47.94MB
 f37786bee968 Downloading [========>                                          ]  27.26MB/160MB
 f37786bee968 Downloading [========>                                          ]  28.31MB/160MB
 0da02031b810 Download complete 
 0da02031b810 Extracting 1 s
 f37786bee968 Downloading [========>                                          ]  28.31MB/160MB
 0da02031b810 Extracting 1 s
 f37786bee968 Downloading [=========>                                         ]  29.36MB/160MB
 0da02031b810 Extracting 1 s
 f37786bee968 Downloading [=========>                                         ]  29.36MB/160MB
 0da02031b810 Extracting 1 s
 f37786bee968 Downloading [=========>                                         ]  30.41MB/160MB
 0da02031b810 Extracting 1 s
 f37786bee968 Downloading [=========>                                         ]  30.41MB/160MB
 0da02031b810 Extracting 1 s
 f37786bee968 Downloading [=========>                                         ]  31.46MB/160MB
 0da02031b810 Extracting 1 s
 f37786bee968 Downloading [==========>                                        ]  32.51MB/160MB
 0da02031b810 Extracting 1 s
 f37786bee968 Downloading [==========>                                        ]  33.55MB/160MB
 0da02031b810 Extracting 1 s
 f37786bee968 Downloading [==========>                                        ]  34.09MB/160MB
 0da02031b810 Extracting 1 s
 f37786bee968 Downloading [==========>                                        ]   34.6MB/160MB
 0da02031b810 Extracting 2 s
 f37786bee968 Downloading [===========>                                       ]  35.65MB/160MB
 0da02031b810 Extracting 2 s
 f37786bee968 Downloading [===========>                                       ]   36.7MB/160MB
 0da02031b810 Extracting 2 s
 f37786bee968 Downloading [===========>                                       ]  37.75MB/160MB
 0da02031b810 Extracting 2 s
 f37786bee968 Downloading [============>                                      ]   38.8MB/160MB
 0da02031b810 Extracting 2 s
 f37786bee968 Downloading [============>                                      ]   38.8MB/160MB
 0da02031b810 Pull complete 
 f37786bee968 Downloading [============>                                      ]  40.55MB/160MB
 661f04f054c4 Extracting 1 s
 f37786bee968 Downloading [============>                                      ]  40.89MB/160MB
 661f04f054c4 Pull complete 
 f37786bee968 Downloading [=============>                                     ]  41.94MB/160MB
 f37786bee968 Downloading [=============>                                     ]  42.99MB/160MB
 1441bc0931d1 Pull complete 
 f37786bee968 Downloading [=============>                                     ]  42.99MB/160MB
 a67ddc05b7f8 Extracting 1 s
 f37786bee968 Downloading [=============>                                     ]  44.04MB/160MB
 a67ddc05b7f8 Extracting 1 s
 f37786bee968 Downloading [=============>                                     ]  44.04MB/160MB
 a67ddc05b7f8 Pull complete 
 f37786bee968 Downloading [==============>                                    ]  45.09MB/160MB
 f37786bee968 Downloading [==============>                                    ]  46.14MB/160MB
 20b7464ce26b Pull complete 
 343c451c026a Extracting 1 s
 f37786bee968 Downloading [==============>                                    ]  47.19MB/160MB
 343c451c026a Pull complete 
 f37786bee968 Downloading [==============>                                    ]  47.19MB/160MB
 330a9fb3841e Extracting 1 s
 f37786bee968 Downloading [===============>                                   ]  48.23MB/160MB
 330a9fb3841e Extracting 1 s
 f37786bee968 Downloading [===============>                                   ]  49.28MB/160MB
 330a9fb3841e Extracting 1 s
 f37786bee968 Downloading [===============>                                   ]  50.33MB/160MB
 330a9fb3841e Extracting 1 s
 f37786bee968 Downloading [===============>                                   ]  50.33MB/160MB
 330a9fb3841e Extracting 1 s
 f37786bee968 Downloading [================>                                  ]  51.38MB/160MB
 330a9fb3841e Extracting 1 s
 f37786bee968 Downloading [================>                                  ]  51.38MB/160MB
 330a9fb3841e Extracting 1 s
 f37786bee968 Downloading [================>                                  ]  52.43MB/160MB
 330a9fb3841e Extracting 1 s
 f37786bee968 Downloading [================>                                  ]  53.48MB/160MB
 330a9fb3841e Extracting 1 s
 f37786bee968 Downloading [================>                                  ]  53.48MB/160MB
 330a9fb3841e Extracting 1 s
 f37786bee968 Downloading [=================>                                 ]  55.57MB/160MB
 330a9fb3841e Extracting 1 s
 f37786bee968 Downloading [=================>                                 ]  56.62MB/160MB
 330a9fb3841e Extracting 2 s
 f37786bee968 Downloading [==================>                                ]  57.67MB/160MB
 330a9fb3841e Extracting 2 s
 f37786bee968 Downloading [==================>                                ]  57.67MB/160MB
 330a9fb3841e Extracting 2 s
 f37786bee968 Downloading [==================>                                ]  57.67MB/160MB
 330a9fb3841e Extracting 2 s
 f37786bee968 Downloading [==================>                                ]  58.72MB/160MB
 330a9fb3841e Extracting 2 s
 f37786bee968 Downloading [==================>                                ]  59.77MB/160MB
 330a9fb3841e Pull complete 
 f37786bee968 Downloading [===================>                               ]  60.82MB/160MB
 a95bd78f8620 Extracting 1 s
 f37786bee968 Downloading [===================>                               ]  61.87MB/160MB
 a95bd78f8620 Pull complete 
 f37786bee968 Downloading [===================>                               ]  62.91MB/160MB
 f37786bee968 Downloading [===================>                               ]  63.96MB/160MB
 f37786bee968 Downloading [====================>                              ]  65.01MB/160MB
 f37786bee968 Downloading [====================>                              ]  66.06MB/160MB
 f37786bee968 Downloading [====================>                              ]  66.06MB/160MB
 f37786bee968 Downloading [====================>                              ]  67.11MB/160MB
 f37786bee968 Downloading [=====================>                             ]  68.16MB/160MB
 f37786bee968 Downloading [=====================>                             ]  68.16MB/160MB
 f37786bee968 Downloading [=====================>                             ]  69.21MB/160MB
 f37786bee968 Downloading [=====================>                             ]  70.25MB/160MB
 f37786bee968 Downloading [======================>                            ]   71.3MB/160MB
 f37786bee968 Downloading [======================>                            ]  72.35MB/160MB
 f37786bee968 Downloading [======================>                            ]  72.35MB/160MB
 f37786bee968 Downloading [=======================>                           ]  74.45MB/160MB
 f37786bee968 Downloading [=======================>                           ]  74.45MB/160MB
 f37786bee968 Downloading [=======================>                           ]   75.5MB/160MB
 f37786bee968 Downloading [=======================>                           ]  76.55MB/160MB
 f37786bee968 Downloading [=======================>                           ]  76.55MB/160MB
 f37786bee968 Downloading [========================>                          ]  77.59MB/160MB
 f37786bee968 Downloading [========================>                          ]  77.59MB/160MB
 f37786bee968 Downloading [========================>                          ]  78.64MB/160MB
 f37786bee968 Downloading [========================>                          ]  79.69MB/160MB
 f37786bee968 Downloading [========================>                          ]  79.69MB/160MB
 f37786bee968 Downloading [=========================>                         ]  80.74MB/160MB
 f37786bee968 Downloading [=========================>                         ]  80.74MB/160MB
 f37786bee968 Downloading [=========================>                         ]  81.79MB/160MB
 f37786bee968 Downloading [=========================>                         ]  81.79MB/160MB
 f37786bee968 Downloading [=========================>                         ]  82.84MB/160MB
 f37786bee968 Downloading [=========================>                         ]  82.84MB/160MB
 f37786bee968 Downloading [=========================>                         ]  82.84MB/160MB
 f37786bee968 Downloading [==========================>                        ]  83.89MB/160MB
 f37786bee968 Downloading [==========================>                        ]  84.93MB/160MB
 f37786bee968 Downloading [==========================>                        ]  84.93MB/160MB
 f37786bee968 Downloading [==========================>                        ]  85.98MB/160MB
 f37786bee968 Downloading [===========================>                       ]  87.03MB/160MB
 f37786bee968 Downloading [===========================>                       ]  88.08MB/160MB
 f37786bee968 Downloading [===========================>                       ]  89.13MB/160MB
 f37786bee968 Downloading [===========================>                       ]  89.13MB/160MB
 f37786bee968 Downloading [============================>                      ]  90.18MB/160MB
 f37786bee968 Downloading [============================>                      ]  90.18MB/160MB
 f37786bee968 Downloading [============================>                      ]  90.18MB/160MB
 f37786bee968 Downloading [============================>                      ]  91.23MB/160MB
 f37786bee968 Downloading [============================>                      ]  91.23MB/160MB
 f37786bee968 Downloading [============================>                      ]  92.27MB/160MB
 f37786bee968 Downloading [=============================>                     ]  93.32MB/160MB
 f37786bee968 Downloading [=============================>                     ]  93.32MB/160MB
 f37786bee968 Downloading [=============================>                     ]  94.37MB/160MB
 f37786bee968 Downloading [=============================>                     ]  94.37MB/160MB
 f37786bee968 Downloading [=============================>                     ]  95.42MB/160MB
 f37786bee968 Downloading [==============================>                    ]  96.47MB/160MB
 f37786bee968 Downloading [==============================>                    ]  96.47MB/160MB
 f37786bee968 Downloading [==============================>                    ]  97.52MB/160MB
 f37786bee968 Downloading [==============================>                    ]  98.57MB/160MB
 f37786bee968 Downloading [===============================>                   ]  99.61MB/160MB
 f37786bee968 Downloading [===============================>                   ]  100.7MB/160MB
 f37786bee968 Downloading [===============================>                   ]  101.7MB/160MB
 f37786bee968 Downloading [===============================>                   ]  101.7MB/160MB
 f37786bee968 Downloading [================================>                  ]  102.8MB/160MB
 f37786bee968 Downloading [================================>                  ]  103.8MB/160MB
 f37786bee968 Downloading [================================>                  ]  104.9MB/160MB
 f37786bee968 Downloading [=================================>                 ]  105.9MB/160MB
 f37786bee968 Downloading [=================================>                 ]  105.9MB/160MB
 f37786bee968 Downloading [=================================>                 ]    107MB/160MB
 f37786bee968 Downloading [=================================>                 ]    108MB/160MB
 f37786bee968 Downloading [==================================>                ]  109.1MB/160MB
 f37786bee968 Downloading [==================================>                ]  110.1MB/160MB
 f37786bee968 Downloading [==================================>                ]  110.1MB/160MB
 f37786bee968 Downloading [==================================>                ]  111.1MB/160MB
 f37786bee968 Downloading [===================================>               ]  112.2MB/160MB
 f37786bee968 Downloading [===================================>               ]  112.2MB/160MB
 f37786bee968 Downloading [===================================>               ]  113.2MB/160MB
 f37786bee968 Downloading [===================================>               ]  114.3MB/160MB
 f37786bee968 Downloading [====================================>              ]  115.3MB/160MB
 f37786bee968 Downloading [====================================>              ]  116.4MB/160MB
 f37786bee968 Downloading [====================================>              ]  116.4MB/160MB
 f37786bee968 Downloading [====================================>              ]  117.4MB/160MB
 f37786bee968 Downloading [=====================================>             ]  118.5MB/160MB
 f37786bee968 Downloading [=====================================>             ]  119.5MB/160MB
 f37786bee968 Downloading [=====================================>             ]  120.6MB/160MB
 f37786bee968 Downloading [=====================================>             ]  120.6MB/160MB
 f37786bee968 Downloading [======================================>            ]  121.6MB/160MB
 f37786bee968 Downloading [======================================>            ]  122.7MB/160MB
 f37786bee968 Downloading [======================================>            ]  123.7MB/160MB
 f37786bee968 Downloading [=======================================>           ]  124.8MB/160MB
 f37786bee968 Downloading [=======================================>           ]    125MB/160MB
 f37786bee968 Downloading [=======================================>           ]  125.8MB/160MB
 f37786bee968 Downloading [=======================================>           ]  126.9MB/160MB
 f37786bee968 Downloading [=======================================>           ]  126.9MB/160MB
 f37786bee968 Downloading [========================================>          ]    129MB/160MB
 f37786bee968 Downloading [========================================>          ]    129MB/160MB
 f37786bee968 Downloading [========================================>          ]    130MB/160MB
 f37786bee968 Downloading [========================================>          ]  131.1MB/160MB
 f37786bee968 Downloading [=========================================>         ]  132.1MB/160MB
 f37786bee968 Downloading [=========================================>         ]  132.1MB/160MB
 f37786bee968 Downloading [=========================================>         ]  133.2MB/160MB
 f37786bee968 Downloading [=========================================>         ]  134.2MB/160MB
 f37786bee968 Downloading [==========================================>        ]  135.3MB/160MB
 f37786bee968 Downloading [==========================================>        ]  136.3MB/160MB
 f37786bee968 Downloading [==========================================>        ]  136.3MB/160MB
 f37786bee968 Downloading [==========================================>        ]  136.3MB/160MB
 f37786bee968 Downloading [==========================================>        ]  137.4MB/160MB
 f37786bee968 Downloading [===========================================>       ]  138.4MB/160MB
 f37786bee968 Downloading [===========================================>       ]  139.5MB/160MB
 f37786bee968 Downloading [===========================================>       ]  140.5MB/160MB
 f37786bee968 Downloading [============================================>      ]  141.6MB/160MB
 f37786bee968 Downloading [============================================>      ]  142.6MB/160MB
 f37786bee968 Downloading [============================================>      ]  143.7MB/160MB
 f37786bee968 Downloading [=============================================>     ]  144.7MB/160MB
 f37786bee968 Downloading [=============================================>     ]  144.7MB/160MB
 f37786bee968 Downloading [=============================================>     ]  145.8MB/160MB
 f37786bee968 Downloading [=============================================>     ]  146.8MB/160MB
 f37786bee968 Downloading [=============================================>     ]  146.8MB/160MB
 f37786bee968 Downloading [==============================================>    ]  147.8MB/160MB
 f37786bee968 Downloading [==============================================>    ]  148.9MB/160MB
 f37786bee968 Downloading [==============================================>    ]  149.9MB/160MB
 f37786bee968 Downloading [===============================================>   ]    151MB/160MB
 f37786bee968 Downloading [===============================================>   ]    151MB/160MB
 f37786bee968 Downloading [===============================================>   ]    152MB/160MB
 f37786bee968 Downloading [===============================================>   ]  153.1MB/160MB
 f37786bee968 Downloading [================================================>  ]  154.1MB/160MB
 f37786bee968 Downloading [================================================>  ]  154.1MB/160MB
 f37786bee968 Downloading [================================================>  ]  155.2MB/160MB
 f37786bee968 Downloading [================================================>  ]  156.2MB/160MB
 f37786bee968 Downloading [=================================================> ]  157.3MB/160MB
 f37786bee968 Downloading [=================================================> ]  157.3MB/160MB
 f37786bee968 Downloading [=================================================> ]  158.3MB/160MB
 f37786bee968 Downloading [=================================================> ]  159.4MB/160MB
 f37786bee968 Download complete 
 f37786bee968 Extracting 1 s
 f37786bee968 Extracting 1 s
 f37786bee968 Extracting 1 s
 f37786bee968 Extracting 1 s
 f37786bee968 Extracting 1 s
 f37786bee968 Extracting 1 s
 f37786bee968 Extracting 1 s
 f37786bee968 Extracting 1 s
 f37786bee968 Extracting 1 s
 f37786bee968 Extracting 1 s
 f37786bee968 Extracting 1 s
 f37786bee968 Extracting 2 s
 f37786bee968 Extracting 2 s
 f37786bee968 Extracting 2 s
 f37786bee968 Extracting 2 s
 f37786bee968 Extracting 2 s
 f37786bee968 Extracting 2 s
 f37786bee968 Extracting 2 s
 f37786bee968 Extracting 2 s
 f37786bee968 Extracting 2 s
 f37786bee968 Extracting 3 s
 f37786bee968 Extracting 3 s
 f37786bee968 Extracting 3 s
 f37786bee968 Extracting 3 s
 f37786bee968 Extracting 3 s
 f37786bee968 Extracting 3 s
 f37786bee968 Extracting 3 s
 f37786bee968 Extracting 3 s
 f37786bee968 Extracting 3 s
 f37786bee968 Extracting 3 s
 f37786bee968 Extracting 4 s
 f37786bee968 Extracting 4 s
 f37786bee968 Extracting 4 s
 f37786bee968 Extracting 4 s
 f37786bee968 Extracting 4 s
 f37786bee968 Extracting 4 s
 f37786bee968 Extracting 4 s
 f37786bee968 Extracting 4 s
 f37786bee968 Extracting 4 s
 f37786bee968 Extracting 4 s
 f37786bee968 Extracting 5 s
 f37786bee968 Extracting 5 s
 f37786bee968 Extracting 5 s
 f37786bee968 Extracting 5 s
 f37786bee968 Extracting 5 s
 f37786bee968 Extracting 5 s
 f37786bee968 Extracting 5 s
 f37786bee968 Extracting 5 s
 f37786bee968 Extracting 5 s
 f37786bee968 Extracting 5 s
 f37786bee968 Extracting 5 s
 f37786bee968 Extracting 6 s
 f37786bee968 Extracting 6 s
 f37786bee968 Extracting 6 s
 f37786bee968 Extracting 6 s
 f37786bee968 Extracting 6 s
 f37786bee968 Extracting 6 s
 f37786bee968 Extracting 6 s
 f37786bee968 Extracting 6 s
 f37786bee968 Extracting 6 s
 f37786bee968 Extracting 6 s
 f37786bee968 Extracting 7 s
 f37786bee968 Extracting 7 s
 f37786bee968 Extracting 7 s
 f37786bee968 Extracting 7 s
 f37786bee968 Extracting 7 s
 f37786bee968 Extracting 7 s
 f37786bee968 Extracting 7 s
 f37786bee968 Extracting 7 s
 f37786bee968 Extracting 7 s
 f37786bee968 Extracting 8 s
 f37786bee968 Extracting 8 s
 f37786bee968 Extracting 8 s
 f37786bee968 Extracting 8 s
 f37786bee968 Extracting 8 s
 f37786bee968 Extracting 8 s
 f37786bee968 Extracting 8 s
 f37786bee968 Extracting 8 s
 f37786bee968 Extracting 8 s
 f37786bee968 Extracting 8 s
 f37786bee968 Extracting 9 s
 f37786bee968 Extracting 9 s
 f37786bee968 Extracting 9 s
 f37786bee968 Pull complete 
 6bdafce1e6fb Pull complete 
 database Pulled 
 Network devops-a07-compose-app_default  Creating
 Network devops-a07-compose-app_default  Created
 Container devops-a07-compose-app-frontend-1  Creating
 Container devops-a07-compose-app-backend-1  Creating
 Container devops-a07-compose-app-database-1  Creating
 Container devops-a07-compose-app-database-1  Created
 Container devops-a07-compose-app-frontend-1  Created
 Container devops-a07-compose-app-backend-1  Created
 Container devops-a07-compose-app-backend-1  Starting
 Container devops-a07-compose-app-database-1  Starting
 Container devops-a07-compose-app-frontend-1  Starting
 Container devops-a07-compose-app-backend-1  Started
 Container devops-a07-compose-app-frontend-1  Started
 Container devops-a07-compose-app-database-1  Started
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
+ break
+ [[ compose-app == demo ]]
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-compose-app -f compose-app/compose.yaml ps
NAME                                IMAGE     COMMAND                  SERVICE    CREATED         STATUS                  PORTS
devops-a07-compose-app-backend-1    nginx     "/docker-entrypoint.…"   backend    2 seconds ago   Up 1 second             80/tcp
devops-a07-compose-app-database-1   mysql     "docker-entrypoint.s…"   database   2 seconds ago   Up Less than a second   3306/tcp, 33060/tcp
devops-a07-compose-app-frontend-1   nginx     "/docker-entrypoint.…"   frontend   2 seconds ago   Up Less than a second   0.0.0.0:8081->80/tcp, [::]:8081->80/tcp
+ docker volume ls --filter label=com.docker.compose.project=devops-a07-compose-app
DRIVER    VOLUME NAME
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-compose-app -f compose-app/compose.yaml down -v
 Container devops-a07-compose-app-database-1  Stopping
 Container devops-a07-compose-app-frontend-1  Stopping
 Container devops-a07-compose-app-backend-1  Stopping
 Container devops-a07-compose-app-backend-1  Stopped
 Container devops-a07-compose-app-backend-1  Removing
 Container devops-a07-compose-app-frontend-1  Stopped
 Container devops-a07-compose-app-frontend-1  Removing
 Container devops-a07-compose-app-frontend-1  Removed
 Container devops-a07-compose-app-backend-1  Removed
 Container devops-a07-compose-app-database-1  Stopped
 Container devops-a07-compose-app-database-1  Removing
 Container devops-a07-compose-app-database-1  Removed
 Network devops-a07-compose-app_default  Removing
 Network devops-a07-compose-app_default  Removed
+ for demo in basic compose-app demo
+ [[ demo == demo ]]
+ compose_file=demo/docker-compose.yml
+ project=devops-a07-demo
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-demo -f demo/docker-compose.yml config -q
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-demo -f demo/docker-compose.yml up -d --build
#1 [internal] load local bake definitions
#1 reading from stdin 607B done
#1 DONE 0.0s

#2 [internal] load build definition from Dockerfile
#2 transferring dockerfile:
#2 transferring dockerfile: 205B 0.0s done
#2 DONE 0.3s

#3 [internal] load metadata for docker.io/library/python:3.12-slim
#3 DONE 2.9s

#4 [internal] load .dockerignore
#4 transferring context:
#4 transferring context: 2B 0.0s done
#4 DONE 0.3s

#5 [internal] load build context
#5 transferring context: 1.26kB 0.0s done
#5 DONE 0.5s

#6 [1/5] FROM docker.io/library/python:3.12-slim@sha256:05cda9777409a9c3ffddd94a4c476b79f0769a0b4857f0c7ed9226b6800b0d6f
#6 resolve docker.io/library/python:3.12-slim@sha256:05cda9777409a9c3ffddd94a4c476b79f0769a0b4857f0c7ed9226b6800b0d6f 0.2s done
#6 DONE 1.0s

#6 [1/5] FROM docker.io/library/python:3.12-slim@sha256:05cda9777409a9c3ffddd94a4c476b79f0769a0b4857f0c7ed9226b6800b0d6f
#6 sha256:bbc5a12237474ec0b23b5051260d56d6436a24d70d9cad961adebe7a037ed813 0B / 249B 0.2s
#6 sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4 0B / 12.12MB 0.2s
#6 sha256:75b6a36c64a1cf3520fc4b4aae4739d5caa8a6a05c27835a920a61784c9c32f8 0B / 1.29MB 0.2s
#6 sha256:bbc5a12237474ec0b23b5051260d56d6436a24d70d9cad961adebe7a037ed813 249B / 249B 0.3s done
#6 sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4 1.05MB / 12.12MB 1.1s
#6 sha256:75b6a36c64a1cf3520fc4b4aae4739d5caa8a6a05c27835a920a61784c9c32f8 1.29MB / 1.29MB 1.2s done
#6 extracting sha256:75b6a36c64a1cf3520fc4b4aae4739d5caa8a6a05c27835a920a61784c9c32f8
#6 sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4 2.10MB / 12.12MB 1.5s
#6 extracting sha256:75b6a36c64a1cf3520fc4b4aae4739d5caa8a6a05c27835a920a61784c9c32f8 0.2s done
#6 sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4 3.15MB / 12.12MB 2.0s
#6 sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4 4.19MB / 12.12MB 2.3s
#6 sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4 5.24MB / 12.12MB 2.4s
#6 sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4 6.29MB / 12.12MB 2.6s
#6 sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4 7.34MB / 12.12MB 2.7s
#6 sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4 8.39MB / 12.12MB 3.0s
#6 sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4 9.44MB / 12.12MB 3.2s
#6 sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4 10.49MB / 12.12MB 3.3s
#6 sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4 12.12MB / 12.12MB 3.5s
#6 sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4 12.12MB / 12.12MB 3.5s done
#6 extracting sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4
#6 extracting sha256:6912e23eb44595b44dc6d9882b34f305ad6f6e9667cec70b13e5dbc4f8cd97f4 0.5s done
#6 DONE 5.2s

#6 [1/5] FROM docker.io/library/python:3.12-slim@sha256:05cda9777409a9c3ffddd94a4c476b79f0769a0b4857f0c7ed9226b6800b0d6f
#6 extracting sha256:bbc5a12237474ec0b23b5051260d56d6436a24d70d9cad961adebe7a037ed813 0.1s done
#6 DONE 5.4s

#7 [2/5] WORKDIR /app
#7 DONE 0.4s

#8 [3/5] COPY requirements.txt .
#8 DONE 0.4s

#9 [4/5] RUN pip install --no-cache-dir -r requirements.txt
#9 2.689 Collecting Flask (from -r requirements.txt (line 1))
#9 2.889   Downloading flask-3.1.3-py3-none-any.whl.metadata (3.2 kB)
#9 2.983 Collecting mysql-connector-python (from -r requirements.txt (line 2))
#9 3.016   Downloading mysql_connector_python-26.7.0-cp312-cp312-manylinux_2_28_x86_64.whl.metadata (11 kB)
#9 3.046 Collecting blinker>=1.9.0 (from Flask->-r requirements.txt (line 1))
#9 3.064   Downloading blinker-1.9.0-py3-none-any.whl.metadata (1.6 kB)
#9 3.099 Collecting click>=8.1.3 (from Flask->-r requirements.txt (line 1))
#9 3.120   Downloading click-8.5.0-py3-none-any.whl.metadata (2.6 kB)
#9 3.147 Collecting itsdangerous>=2.2.0 (from Flask->-r requirements.txt (line 1))
#9 3.166   Downloading itsdangerous-2.2.0-py3-none-any.whl.metadata (1.9 kB)
#9 3.200 Collecting jinja2>=3.1.2 (from Flask->-r requirements.txt (line 1))
#9 3.220   Downloading jinja2-3.1.6-py3-none-any.whl.metadata (2.9 kB)
#9 3.320 Collecting markupsafe>=2.1.1 (from Flask->-r requirements.txt (line 1))
#9 3.348   Downloading markupsafe-3.0.4-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl.metadata (2.7 kB)
#9 3.398 Collecting werkzeug>=3.1.0 (from Flask->-r requirements.txt (line 1))
#9 3.421   Downloading werkzeug-3.1.9-py3-none-any.whl.metadata (4.1 kB)
#9 3.453 Downloading flask-3.1.3-py3-none-any.whl (103 kB)
#9 3.507 Downloading mysql_connector_python-26.7.0-cp312-cp312-manylinux_2_28_x86_64.whl (21.7 MB)
#9 7.236    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 21.7/21.7 MB 5.8 MB/s eta 0:00:00
#9 7.256 Downloading blinker-1.9.0-py3-none-any.whl (8.5 kB)
#9 7.296 Downloading click-8.5.0-py3-none-any.whl (125 kB)
#9 7.322 Downloading itsdangerous-2.2.0-py3-none-any.whl (16 kB)
#9 7.351 Downloading jinja2-3.1.6-py3-none-any.whl (134 kB)
#9 7.387 Downloading markupsafe-3.0.4-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (22 kB)
#9 7.407 Downloading werkzeug-3.1.9-py3-none-any.whl (228 kB)
#9 7.484 Installing collected packages: mysql-connector-python, markupsafe, itsdangerous, click, blinker, werkzeug, jinja2, Flask
#9 9.182 Successfully installed Flask-3.1.3 blinker-1.9.0 click-8.5.0 itsdangerous-2.2.0 jinja2-3.1.6 markupsafe-3.0.4 mysql-connector-python-26.7.0 werkzeug-3.1.9
#9 9.183 WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager, possibly rendering your system unusable. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv. Use the --root-user-action option if you know what you are doing and want to suppress this warning.
#9 9.628 
#9 9.628 [notice] A new release of pip is available: 25.0.1 -> 26.2.1
#9 9.628 [notice] To update, run: pip install --upgrade pip
#9 DONE 10.0s

#10 [5/5] COPY app.py .
#10 DONE 0.5s

#11 exporting to image
#11 exporting layers
#11 exporting layers 5.4s done
#11 exporting manifest sha256:0681f7b2b07cab87f67b3e724ae6598740a4bfeb3006ee49ca73fa394861cd5b 0.1s done
#11 exporting config sha256:3c27ddb049a9eef8b35a2e992281cf9347a365983a11a59bca7932f5fa561429
#11 exporting config sha256:3c27ddb049a9eef8b35a2e992281cf9347a365983a11a59bca7932f5fa561429 0.1s done
#11 exporting attestation manifest sha256:da2330eac44700f5ccd8c78df022be2e607bfc228ae52eec4a96645b5122b063
#11 exporting attestation manifest sha256:da2330eac44700f5ccd8c78df022be2e607bfc228ae52eec4a96645b5122b063 0.3s done
#11 exporting manifest list sha256:cd3547d50396032ba0c74671bf2e2cd97b87d7751fcdb47aaa4c7e5dd2fcf03b
#11 exporting manifest list sha256:cd3547d50396032ba0c74671bf2e2cd97b87d7751fcdb47aaa4c7e5dd2fcf03b 0.1s done
#11 naming to docker.io/library/devops-a07-demo-backend:latest
#11 naming to docker.io/library/devops-a07-demo-backend:latest 0.0s done
#11 unpacking to docker.io/library/devops-a07-demo-backend:latest
#11 unpacking to docker.io/library/devops-a07-demo-backend:latest 1.2s done
#11 DONE 7.5s

#12 resolving provenance for metadata file
#12 DONE 0.0s
 devops-a07-demo-backend  Built
 Network devops-a07-demo_backend_net  Creating
 Network devops-a07-demo_backend_net  Created
 Network devops-a07-demo_frontend_net  Creating
 Network devops-a07-demo_frontend_net  Created
 Volume devops-a07-demo_db_data  Creating
 Volume devops-a07-demo_db_data  Created
 Container devops-a07-demo-database-1  Creating
 Container devops-a07-demo-frontend-1  Creating
 Container devops-a07-demo-frontend-1  Created
 Container devops-a07-demo-database-1  Created
 Container devops-a07-demo-backend-1  Creating
 Container devops-a07-demo-backend-1  Created
 Container devops-a07-demo-database-1  Starting
 Container devops-a07-demo-frontend-1  Starting
 Container devops-a07-demo-frontend-1  Started
 Container devops-a07-demo-database-1  Started
 Container devops-a07-demo-backend-1  Starting
 Container devops-a07-demo-backend-1  Started
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
curl: (56) Recv failure: Connection reset by peer
+ sleep 2
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081
+ break
+ [[ demo == demo ]]
+ for attempt in {1..60}
+ curl -fsS http://127.0.0.1:8081/api
+ break
+ grep -q 'Hello from MySQL' evidence/api.json
+ /tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 02-three-tier-app --url http://127.0.0.1:8081
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-demo -f demo/docker-compose.yml exec -T backend python -c 'import socket; print("database DNS:",socket.gethostbyname("database"))'
database DNS: 172.18.0.2
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-demo -f demo/docker-compose.yml ps
NAME                         IMAGE                     COMMAND                  SERVICE    CREATED              STATUS                   PORTS
devops-a07-demo-backend-1    devops-a07-demo-backend   "python app.py"          backend    19 seconds ago       Up 7 seconds (healthy)   5000/tcp
devops-a07-demo-database-1   mysql:8.0                 "docker-entrypoint.s…"   database   About a minute ago   Up About a minute        3306/tcp, 33060/tcp
devops-a07-demo-frontend-1   nginx:latest              "/docker-entrypoint.…"   frontend   About a minute ago   Up 4 seconds             0.0.0.0:8081->80/tcp, [::]:8081->80/tcp
+ docker volume ls --filter label=com.docker.compose.project=devops-a07-demo
DRIVER    VOLUME NAME
local     devops-a07-demo_db_data
+ docker compose --env-file /workspace/.local-tools/runtime/mysql.env -p devops-a07-demo -f demo/docker-compose.yml down -v
 Container devops-a07-demo-frontend-1  Stopping
 Container devops-a07-demo-frontend-1  Stopped
 Container devops-a07-demo-frontend-1  Removing
 Container devops-a07-demo-frontend-1  Removed
 Container devops-a07-demo-backend-1  Stopping
 Container devops-a07-demo-backend-1  Stopped
 Container devops-a07-demo-backend-1  Removing
 Container devops-a07-demo-backend-1  Removed
 Container devops-a07-demo-database-1  Stopping
 Container devops-a07-demo-database-1  Stopped
 Container devops-a07-demo-database-1  Removing
 Container devops-a07-demo-database-1  Removed
 Volume devops-a07-demo_db_data  Removing
 Network devops-a07-demo_frontend_net  Removing
 Network devops-a07-demo_backend_net  Removing
 Volume devops-a07-demo_db_data  Removed
 Network devops-a07-demo_frontend_net  Removed
 Network devops-a07-demo_backend_net  Removed

```
