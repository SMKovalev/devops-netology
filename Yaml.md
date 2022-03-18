# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import time
import socket
import datetime
import yaml
import json

i = 1
# Delay in seconds
wait = 1
server = {'drive.google.com':'0.0.0.0', 'mail.google.com':'0.0.0.0', 'google.com':'0.0.0.0'}
init = 0
file_path = "/home/vagrant/PycharmProjects/pythonProject/venv/"

print('*** start script ***')
print(server)
print('********************')

now = datetime.datetime.now()
while 1 == 1:
    for host in server:
        ip = socket.gethostbyname(host)
        if ip != server[host]:
            if i == 1 and init != 1:
                print(str(now.strftime("%Y-%m-%d %H:%M:%S")) + ' [ERROR] ' + str(host) + ' IP mistmatch: ' + server[host] + ' ' + ip)
#Print in json file
                with open(file_path + host + ".json", 'w') as jsf:
                    json_data = json.dumps({host: ip}, indent=2)
                    jsf.write(json_data)
                    print("Create file "+ host +".json")
# Print in yaml file
                with open(file_path + host + ".yaml", 'w') as ymf:
                    yaml_data = yaml.dump([{host: ip}], explicit_start=True, explicit_end=True)
                    ymf.write(yaml_data)
                    print("Create file "+ host +".yaml")
            server[host] = ip
    i += 1
    if i >= 2:
        break
    time.sleep(wait)
```

### Вывод скрипта при запуске при тестировании:
```
vagrant@vagrant:~/PycharmProjects/pythonProject/venv$ /home/vagrant/PycharmProjects/pythonProject/venv/Test2.py
*** start script ***
{'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0'}
********************
2022-03-18 17:46:39 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 142.250.74.14
Create file drive.google.com.json
Create file drive.google.com.yaml
2022-03-18 17:46:39 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 142.250.74.165
Create file mail.google.com.json
Create file mail.google.com.yaml
2022-03-18 17:46:39 [ERROR] google.com IP mistmatch: 0.0.0.0 142.250.74.174
Create file google.com.json
Create file google.com.yaml

```

### json-файл(ы), который(е) записал ваш скрипт:
```json
vagrant@vagrant:~/PycharmProjects/pythonProject/venv$ ls *.json
drive.google.com.json  google.com.json  mail.google.com.json

```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
vagrant@vagrant:~/PycharmProjects/pythonProject/venv$ ls *.yaml
drive.google.com.yaml  google.com.yaml  mail.google.com.yaml

```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

### Ваш скрипт:
```python
???
```

### Пример работы скрипта:
???