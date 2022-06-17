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

postmaster invoked oom-killer

Как вы думаете, что происходит?
Как бы вы решили данную проблему?

**Причина в недостатке ресурсов оперативной памяти**

В результате ОС завершает процессы утилизирующие память, чтобы предотвратить падение всей системы.
Для предотвращения сбоев надо:
- выставить ограничение в настройках PG на использование ресурсов хоста, чтобы исключить потребление всех ресурсов на машине.
- желательно увеличить объем оперативной памяти.