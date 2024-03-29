# Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ"

## Задача 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно).
Если в рамках предыдущего задания у вас уже есть аккаунт AWS, то давайте продолжим знакомство со взаимодействием терраформа и aws.

Создайте s3 бакет, iam роль и пользователя от которого будет работать терраформ. Можно создать отдельного пользователя, а можно использовать созданного в рамках предыдущего задания, просто добавьте ему необходимы права, как описано здесь.
Зарегистрируйте бэкэнд в терраформ проекте как описано по ссылке выше.

**Ответ:** С AWS возникли проблемы поэтому делал на облаке яндекс.
Создавал при помощи terraform по документации на https://cloud.yandex.ru/docs/storage/operations/buckets/create

![img_5.png](img_5.png)

![img_4.png](img_4.png)

## Задача 2. Инициализируем проект и создаем воркспейсы.
В виде результата работы пришлите:

Вывод команды terraform workspace list.

- ![img_6.png](img_6.png)

Вывод команды terraform plan для воркспейса prod.
- ![img_7.png](img_7.png)
- ![img_8.png](img_8.png)
- ![img_9.png](img_9.png)
- ![img_10.png](img_10.png)
- ![img_11.png](img_11.png)
- ![img_12.png](img_12.png)
- ![img_13.png](img_13.png)

- ![img_14.png](img_14.png)
