# Домашнее задание к занятию "6.1. Типы и структура СУБД"

## Задача 1
Архитектор ПО решил проконсультироваться у вас, какой тип БД лучше выбрать для хранения определенных данных.

Он вам предоставил следующие типы сущностей, которые нужно будет хранить в БД:

- Электронные чеки в json виде - "Документо-ориентированная" используется для документов json
- Склады и автомобильные дороги для логистической компании - "Сетевая" - иерархическая с множеством узлов.
- Генеалогические деревья - "Иерархическая", используются деревья с одним родителем.
- Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутентификации - "Ключ-значение"
- Отношения клиент-покупка для интернет-магазина - "Реляционная" используется отношение М:М

## Задача 2
Вы создали распределенное высоконагруженное приложение и хотите классифицировать его согласно CAP-теореме. Какой классификации по CAP-теореме соответствует ваша система, если (каждый пункт - это отдельная реализация вашей системы и для каждого пункта надо привести классификацию):

- Данные записываются на все узлы с задержкой до часа (асинхронная запись) : AP, PA-EL
- При сетевых сбоях, система может разделиться на 2 раздельных кластера : CA, EL-PC
- Система может не прислать корректный ответ или сбросить соединение : CP, PA-EC

А согласно PACELC-теореме, как бы вы классифицировали данные реализации?

## Задача 3
Могут ли в одной системе сочетаться принципы BASE и ACID? Почему?
- Принципы BASE и ACID сочетаться не могут. По ACID - данные согласованные, а по BASE - могут быть не консистентными, таким образом они противоречат друг другу.

## Задача 4
Вам дали задачу написать системное решение, основой которого бы послужили:

фиксация некоторых значений с временем жизни
реакция на истечение таймаута
Вы слышали о key-value хранилище, которое имеет механизм Pub/Sub. Что это за система? Какие минусы выбора данной системы?

Согласно лекции это Redis

Минусы Redis:
- Требуются достаточные ресурсы RAM(оперативной памяти)
- отсутствие поддержки языка SQL, т.е. проблема оперативного поиска данных  
- при отказе сервера все данные с последней синхронизации с диском будут утеряны