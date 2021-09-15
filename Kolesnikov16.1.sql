--Автор: Максим Колесников
--Дата: 12.05.2021
--ТЕМА 16. Дополнительные типы данных и их функции
--ТЕМА 17. Функции для обработки типов данных - дата и время. Функции для конвертирования дан
use sample_primer

create table MyUniqueTable (UniqueColumn uniqueidentifier default newid(), Characters varchar(10))
go
insert into MyUniqueTable(Characters) values ('abc')
insert into MyUniqueTable values (newid(), 'def')
go