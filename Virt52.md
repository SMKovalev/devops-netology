# Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"
## Задача 1

    Опишите своими словами основные преимущества применения на практике IaaC паттернов.
    Какой из принципов IaaC является основополагающим?

+ Скорость и уменьшение затрат
+ Масштабируемость и стандартизация
+ Безопасность и документация
+ Быстрое восстановление в аварийных ситуациях

Я считаю основополагающим принципом IaaC является **идемпотентность**

## Задача 2

    Чем Ansible выгодно отличается от других систем управление конфигурациями?
    Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

- Скрипты конфигурирования на YAML
- Не требует установки специального программного обеспечения на узлах
- Работает через стандартные каналы SSH
- Идемпотентное поведение
- Поддержка переменных, условий и циклов
- Использует в своей работе системные сведения
  - собирает серию подробных данных об управляемых узлах, например сетевых интерфейсах и операционной системе, и обозначает эти данные как глобальные переменные, называемые системными сведениями. Сведения можно использовать внутри плейбуков, чтобы обеспечить универсальность и адаптивность автоматизации, работающей по-разному в зависимости от системы конфигурирования.
- Использует систему шаблонов
- Поддержка расширений и модулей
  - поставляется с сотнями встроенных модулей, упрощающих автоматизацию стандартных задач администрирования, таких как установка пакетов с помощью apt и синхронизация файлов через rsync, а также работа с популярными программами, например системами базы данных (MySQL, PostgreSQL, MongoDB и др.) и инструментами управления зависимостями (PHP ​​​​​​composer​​​, Ruby ​​​gem​​​​​​, Node ​​​​​​npm и др.)​​​. Помимо этого существует ряд способов расширения системы Ansible. Это плагины и модули, которые необходимы для обеспечения пользовательских функций, не включенных по умолчанию.- 

## Задача 3

Установить на личный компьютер:

    VirtualBox
    Vagrant
    Ansible

Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.

- Ansible на винде пришлось устанавливать в Cygwin. WLS не взлетел. :(
```
PS C:\Windows\System32> vagrant --version
Vagrant 2.2.19

PS B:\VirtualBox> .\VBoxManage.exe --version
6.1.32r149290

$ ansible --version
ansible 2.8.4
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/Tom/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.7/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.7.12 (default, Nov 23 2021, 18:58:07) [GCC 11.2.0]
```

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

    Создать виртуальную машину.
    Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды

docker ps
```
vagrant@vagrant:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@vagrant:~$ docker version
Client: Docker Engine - Community
 Version:           20.10.12
 API version:       1.41
 Go version:        go1.16.12
 Git commit:        e91ed57
 Built:             Mon Dec 13 11:45:33 2021
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.12
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.16.12
  Git commit:       459d0df
  Built:            Mon Dec 13 11:43:42 2021
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.12
  GitCommit:        7b11cfaabd73bb80907dd23182b9347b4245eb5d
 runc:
  Version:          1.0.2
  GitCommit:        v1.0.2-0-g52b36a2
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```