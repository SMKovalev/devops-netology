# Домашнее задание к занятию "6.6. Troubleshooting"

## Задача 1

Пользователь (разработчик) написал в канал поддержки, что у него уже 3 минуты происходит CRUD операция в MongoDB и её нужно прервать.

Вы как инженер поддержки решили произвести данную операцию:

- Для поиска проблемной операции выполним команду: db.currentOp()
- Завершим операцию по opid командой: db.killOp()

Для исправления проблемы с долгими (зависающими) запросами в MongoDB добавляем/изменяем соответствующие индексы.

## Задача 2

Вы запустили инстанс Redis для использования совместно с сервисом, который использует механизм TTL. Причем отношение количества записанных key-value значений к количеству истёкших значений есть величина постоянная и увеличивается пропорционально количеству реплик сервиса.

При масштабировании сервиса до N реплик вы увидели, что:

сначала рост отношения записанных значений к истекшим
Redis блокирует операции записи
Как вы думаете, в чем может быть проблема?

- **Скорее всего проблема связана с исчерпанием ресурсов оперативной памяти.**

Дополнение по доработке:

- **Возможно проблема связана со сроком "жизни" ключей**
По сути, это означает, что если в базе данных много-много ключей, срок действия которых истекает в одну и ту же секунду,
и они составляют не менее 25% от текущего набора ключей с истекшим сроком действия, Redis может заблокировать ключи, 
срок действия которых уже истек.
Этот подход используется в Redis для того, чтобы избежать использования слишком большого объема памяти для ключей, 
срок действия которых уже истек.

```
На всякий случай добавляю сюда команды для работы с ключами
Создание ключа key_melon со значением “cantaloupe”
- set key_melon "cantaloupe"
Установка срока его действия в 450 секунд.
- expire key_melon 450
завершить срок действия ключа (если временная метка, которую вы передали expireat, относится к прошедшему времени, 
команда немедленно удалит ключ)
- expireat key_melon 1746131400 (8:30 вечера по Гринвичу 1 мая 2025 года)
Проверка срока действия ключа
- ttl key_melon
Сброс настроек непостоянных ключей
- persist key_melon
(Команда persist вернет вывод (integer) 1, если операция прошла успешно – это значит, что срок действия ключа сброшен и 
ключ стал постоянным.)
```

## Задача 3
Вы подняли базу данных MySQL для использования в гис-системе. При росте количества записей, в таблицах базы, пользователи начали жаловаться на ошибки вида:

InterfaceError: (InterfaceError) 2013: Lost connection to MySQL server during query u'SELECT..... '
Как вы думаете, почему это начало происходить и как локализовать проблему?

Какие пути решения данной проблемы вы можете предложить?

Несколько вариантов возникновения проблемы.
1. Рост нагрузки на БД:
Варианты решения:
- Увеличить значение параметров : connect_timeout, interactive_timeout, wait_timeout
- Добавить ресурсов на машине
- Создать индексы для оптимизации  и ускорения запросов (определить по плану запросов)

2. Проблемы на сети.
Варианты решения:
- увеличить параметр : net_read_timeout 
- расширить максимальное число соединений : max_connections

## Задача 4
Вы решили перевести гис-систему из задачи 3 на PostgreSQL, так как прочитали в документации, что эта СУБД работает с большим объемом данных лучше, чем MySQL.

После запуска пользователи начали жаловаться, что СУБД время от времени становится недоступной. В dmesg вы видите, что:

*postmaster invoked oom-killer*

Как вы думаете, что происходит?
Как бы вы решили данную проблему?

**Причина в недостатке ресурсов оперативной памяти**

В результате ОС завершает процессы утилизирующие память, чтобы предотвратить падение всей системы.
Для предотвращения сбоев надо:
- **выставить ограничение в настройках PG на использование ресурсов хоста, чтобы исключить потребление всех ресурсов на машине.**

Ниже указаны настройки по использованию оперативной памяти в конфигурационном файле postgresql.conf 

1. shared_buffers (integer)
Задаёт объём памяти, который будет использовать сервер баз данных для буферов в разделяемой памяти.
2. huge_pages (enum)
Определяет, будут ли огромные страницы запрашиваться из основной области общей памяти. 
3. temp_buffers (integer)
Задаёт максимальное число временных буферов для каждого сеанса.
4. max_prepared_transactions (integer)
Задаёт максимальное число транзакций, которые могут одновременно находиться в «подготовленном» состоянии (см. PREPARE TRANSACTION). При нулевом значении (по умолчанию) механизм подготовленных транзакций отключается. Задать этот параметр можно только при запуске сервера.
Если использовать транзакции не планируется, этот параметр следует обнулить, чтобы не допустить непреднамеренного создания подготовленных транзакций. Если же подготовленные транзакции применяются, то max_prepared_transactions, вероятно, должен быть не меньше, чем max_connections, чтобы подготовить транзакцию можно было в каждом сеансе.
5. work_mem (integer)
Задаёт объём памяти, который будет использоваться для внутренних операций сортировки и хеш-таблиц, прежде чем будут задействованы временные файлы на диске. 
6. maintenance_work_mem (integer)
Задаёт максимальный объём памяти для операций обслуживания БД, в частности VACUUM, CREATE INDEX и ALTER TABLE ADD FOREIGN KEY.
7. autovacuum_work_mem (integer)
Задаёт максимальный объём памяти, который будет использовать каждый рабочий процесс автоочистки.
8. max_stack_depth (integer)
Задаёт максимальную безопасную глубину стека для исполнителя. В идеале это значение должно равняться предельному размеру стека, ограниченному ядром (который устанавливается командой ulimit -s или аналогичной), за вычетом запаса примерно в мегабайт. Этот запас необходим, потому что сервер проверяет глубину стека не в каждой процедуре, а только в потенциально рекурсивных процедурах, например, при вычислении выражений. Значение по умолчанию — два мегабайта (2MB) — выбрано с большим запасом, так что риск переполнения стека минимален. Но с другой стороны, его может быть недостаточно для выполнения сложных функций. Изменить этот параметр могут только суперпользователи.
Если max_stack_depth будет превышать фактический предел ядра, то функция с неограниченной рекурсией сможет вызвать крах отдельного процесса сервера. В системах, где PostgreSQL может определить предел, установленный ядром, он не позволит установить для этого параметра небезопасное значение. Однако эту информацию выдают не все системы, поэтому выбирать это значение следует с осторожностью.
9. dynamic_shared_memory_type (enum)
Выбирает механизм динамической разделяемой памяти, который будет использоваться сервером. 

- **Желательно увеличить объем оперативной памяти.**
- **Можно настроить OOM-Killer для PostgreSQL, установить для vm.overcommit_memory значение 2.
Это снизит вероятность принудительного завершения процесса PostgreSQL.**

```
Linux может зарезервировать для процессов больше памяти, чем есть, но не выделять ее по факту, 
и этим поведением управляет параметр ядра Linux. За это отвечает переменная vm.overcommit_memory.
Для нее можно указывать следующие значения:

0: ядро само решает, стоит ли резервировать слишком много памяти. Это значение по умолчанию в большинстве версий Linux.
1: ядро всегда будет резервировать лишнюю память. Это рискованно, ведь память может закончиться, потому что, скорее всего,
однажды процессы затребуют положенное.
2: ядро не будет резервировать больше памяти, чем указано в параметре overcommit_ratio.

В этом параметре вы указываете процент памяти, для которого допустимо избыточное резервирование. Если для него нет места, 
память не выделяется, в резервировании будет отказано. Это самый безопасный вариант, рекомендованный для PostgreSQL. 
На OOM-Killer влияет еще один элемент — возможность подкачки, которой управляет переменная cat /proc/sys/vm/swappiness. 
Эти значения указывают ядру, как обрабатывать подкачку страниц. Чем больше значение, тем меньше вероятности, 
что OOM завершит процесс, но из-за операций ввода-вывода это негативно сказывается на базе данных. 
И наоборот — чем меньше значение, тем выше вероятность вмешательства OOM-Killer, но и производительность базы данных тоже выше. 
Значение по умолчанию 60, но если вся база данных помещается в память, лучше установить значение 1.
```
