# Домашнее задание к занятию "6.2. SQL"

## Задача 1
Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.
```
vagrant@vagrant:~$ docker pull postgres:12
vagrant@vagrant:~$ docker volume create vol2
vol2
vagrant@vagrant:~$ docker volume create vol1
vol1
vagrant@vagrant:~$ docker run --rm --name pg-docker -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v vol1:/var/lib/postgresql/data -v vol2:/var/lib/postgresql postgres:12
```
![img_4.png](img_4.png)

## Задача 2
```
CREATE DATABASE test_db;
CREATE ROLE "test-admin-user" SUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;

CREATE TABLE orders 
(
id integer, 
name text, 
price integer, 
PRIMARY KEY (id) 
);

CREATE TABLE clients 
(
	id integer PRIMARY KEY,
	lastname text,
	country text,
	booking integer,
	FOREIGN KEY (booking) REFERENCES orders (Id)
);

CREATE ROLE "test-simple-user" NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
GRANT SELECT ON TABLE public.clients TO "test-simple-user";
GRANT INSERT ON TABLE public.clients TO "test-simple-user";
GRANT UPDATE ON TABLE public.clients TO "test-simple-user";
GRANT DELETE ON TABLE public.clients TO "test-simple-user";
GRANT SELECT ON TABLE public.orders TO "test-simple-user";
GRANT INSERT ON TABLE public.orders TO "test-simple-user";
GRANT UPDATE ON TABLE public.orders TO "test-simple-user";
GRANT DELETE ON TABLE public.orders TO "test-simple-user";
```
![img_5.png](img_5.png)

![img_7.png](img_7.png)


Приведите:

итоговый список БД после выполнения пунктов выше,
описание таблиц (describe)
SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
список пользователей с правами над таблицами test_db

## Задача 3
![img_9.png](img_9.png)

## Задача 4
![img_10.png](img_10.png)

## Задача 5
![img_11.png](img_11.png)

- Hash - cost показывает стоимость запроса 
- Seq Scan — последовательное, блок за блоком, чтение данных таблицы clients и orders
cost? Это не время, а некое сферическое в вакууме понятие, призванное оценить затратность операции. Первое значение 0.00 — затраты на получение первой строки. Второе — затраты на получение всех строк.
- rows — приблизительное количество возвращаемых строк при выполнении операции.
- width — средний размер одной строки в байтах.
в итоге данная команда показывает стоимость запроса, а также в нашем случае шаги связи, и сбор сканирование таблиц после связи


## Задача 6
Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).
Остановите контейнер с PostgreSQL (но не удаляйте volumes).
Поднимите новый пустой контейнер с PostgreSQL.
Восстановите БД test_db в новом контейнере.
Приведите список операций, который вы применяли для бэкапа данных и восстановления.

```
vagrant@vagrant:~$ docker exec -t pg-docker pg_dump -U postgres test_db -f /var/lib/postgresql/data/dump_test.sql
vagrant@vagrant:~$ docker exec -i pg-docker2 psql -U postgres -d test_db -f /var/lib/postgresql/data/dump_test.sql
SET
SET
SET
SET
SET
 set_config 
------------
 
(1 row)

SET
SET
SET
SET
SET
SET
SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE TABLE
ALTER TABLE
COPY 5
COPY 5
ALTER TABLE
ALTER TABLE
ALTER TABLE
GRANT
GRANT
```

Второй контейнер для задачи поднимал на порту 5433 первый на 5432
