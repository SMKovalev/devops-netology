# Домашнее задание к занятию "6.5. Elasticsearch"
## Задача 1
В этом задании вы потренируетесь в:

- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker 

Используя докер образ centos:7 как базовый и документацию по установке и запуску Elastcisearch:

- составьте Dockerfile-манифест для elasticsearch
![img_1.png](img_1.png)
- соберите docker-образ и сделайте push в ваш docker.io репозиторий
![img.png](img.png)
- запустите контейнер из получившегося образа и выполните запрос пути / c хост-машины
![img_2.png](img_2.png)

Требования к elasticsearch.yml:

- данные path должны сохраняться в /var/lib
- имя ноды должно быть netology_test
В ответе приведите:

- текст Dockerfile манифеста
- ссылку на образ в репозитории dockerhub
- ответ elasticsearch на запрос пути / в json виде

Подсказки:

возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum
при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
при некоторых проблемах вам поможет docker директива ulimit
elasticsearch в логах обычно описывает проблему и пути ее решения
Далее мы будем работать с данным экземпляром elasticsearch.

## Задача 2
В этом задании вы научитесь:

создавать и удалять индексы
изучать состояние кластера
обосновывать причину деградации доступности данных
Ознакомтесь с документацией и добавьте в elasticsearch 3 индекса, в соответствии со таблицей:

|Имя	|Количество реплик	| Количество шард |
| ------------- |:-------------:|:---------------:|
|ind-1	|0	|        1        |
|ind-2	|1	|        2        |
|ind-3	|2	|        4        |

![img_31.png](img_31.png)

Получите список индексов и их статусов, используя API и приведите в ответе на задание.

![img_32.png](img_32.png)

![img_34.png](img_34.png)

Получите состояние кластера elasticsearch, используя API.

![img_33.png](img_33.png)

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

- индексы находятся в статусе Yellow, потому что у них указано число реплик, но фактически других серверов нет, поэтому реплицировать данные некуда.

Удалите все индексы.

![img_35.png](img_35.png)

Важно

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард, иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

## Задача 3
В данном задании вы научитесь:

создавать бэкапы данных
восстанавливать индексы из бэкапов
Создайте директорию {путь до корневой директории с elasticsearch в образе}/snapshots.

Используя API зарегистрируйте данную директорию как snapshot repository c именем netology_backup.

Приведите в ответе запрос API и результат вызова API для создания репозитория.

Создайте индекс test с 0 реплик и 1 шардом и приведите в ответе список индексов.

Создайте snapshot состояния кластера elasticsearch.

Приведите в ответе список файлов в директории со snapshotами.

Удалите индекс test и создайте индекс test-2. Приведите в ответе список индексов.

Восстановите состояние кластера elasticsearch из snapshot, созданного ранее.

Приведите в ответе запрос к API восстановления и итоговый список индексов.

Подсказки:

возможно вам понадобится доработать elasticsearch.yml в части директивы path.repo и перезапустить elasticsearch