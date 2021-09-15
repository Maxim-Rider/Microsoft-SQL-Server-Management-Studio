--20.2 SQL (VIEW) Представления - обработка личного кода (isikukood)
--Автор: Максим Колесников
--Дата: 27.05.2021

create database Isikukood

use Isikukood

create table Personal_Data (
name varchar(30), 
idcode char(11)
)

insert into Personal_Data values ('Maxim Kolesnikov', '50103273728')
insert into Personal_Data values ('Viktor Pomokalov', '50305300218')
insert into Personal_Data values ('Elena Petrova', '60210020019')
insert into Personal_Data values ('Natalja Koloskova', '47003271298')
insert into Personal_Data values ('Sergei Ivanov', '36005305010')



select *, left(idcode, 1) as 'First Number', 
	case
		when left(idcode, 1) in('5', '3') then 'Man'
		when left(idcode, 1) in('4', '6') then 'Woman'
	end Gender,
	SUBSTRING(idcode, 6, 2) as 'birth day',
    SUBSTRING(idcode, 4, 2) as 'birth month',
	SUBSTRING(idcode, 2, 2) as 'birth year'

from Personal_Data
--

