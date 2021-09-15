--Автор: Максим Колесников
--Дата: 04.05.2021
--11.3 Проект "Применение SQL запросов, категории DDL - база данных AUTOD"

--1. Создайте базу данных (регистрация продаваемых машин)
CREATE DATABASE Kolesnikov11_3;
Use Kolesnikov11_3

--2. Создайте таблицу (1) - (подержанные), поля (марка, модель, год выпуска, цена,
--статус (в продаже/уже продана – Yes/No, по умолчанию Yes, или 1/0 по умолчанию 1))
Create table UsedCars (
mark varchar(20),
model varchar(20),
release_year char(4),
price money,
status varchar(20) default 'Yes',
check (status in('Yes','No'))
);
--a. Вставьте мин. 3 записи (машины одной марки (1)) – запрос INSERT …
select * from UsedCars
Insert UsedCars (mark, model, release_year, price) values ('Audi', 'R8', '2020', '165000')
Insert UsedCars (mark, model, release_year, price) values ('Audi', 'RS7', '2015', '55000')
Insert UsedCars (mark, model, release_year, price) values ('Audi', 'Q7', '2006', '7200')

--3. Измените структуру таблицы, добавьте в таблицу (1) поле – состояние машины, со значением
--по умолчанию (например: хорошее)
Alter table UsedCars add condition varchar(20) default 'good'

--a. Вставьте мин. 2 записи (машины другой марки (2))
select * from UsedCars
Insert UsedCars (mark, model, release_year, price) values ('BMW', 'i8', '2018', '77000')
Insert UsedCars (mark, model, release_year, price) values ('BMW', 'X6', '2008', '12000')
Insert UsedCars (mark, model, release_year, price) values ('BMW', 'M3', '2009', '22900')

--4. Измените тип данных у поля состояние машины (например: увеличьте или уменьшите длину
--поля, измените тип данных char или varchar)
Alter table UsedCars alter column condition varchar(30)


--a. Вставьте мин. 1 запись (машины той же марки (2))
Insert UsedCars (mark, model, release_year, price) values ('BMW', 'M6', '2013', '52860')

--5. Измените значение по умолчанию поля состояние машины (например: отличное)
alter table UsedCars drop constraint DF__UsedCars__condit__59063A47
go
alter table UsedCars add constraint DF__UsedCars__condit__59063A47 default 'great' for condition

--Получить имя ограничений
exec sp_helpconstraint UsedCars


--a. Вставьте мин. 2 записи (машины другой марки (3))
select * from UsedCars
Insert UsedCars (mark, model, release_year, price) values ('Honda', 'Civic', '2021', '26300')
Insert UsedCars (mark, model, release_year, price) values ('Honda', 'CR-V', '2019', '34890')

--6. Добавьте в таблицу (1) поле код регистрации машины, автозаполняемое поле, в начальном
--значении которого укажите год и номер регистрации (например: 20170001)
Alter table UsedCars add reg_code int identity (20170001, 1)

--a. Вставьте мин. 1 запись (машины той же марки (3))
select * from UsedCars
Insert UsedCars (mark, model, release_year, price) values ('Honda', 'Accord', '2014', '12100')

--7. Новый год начинается с изменения кода регистрации (например: 20180001),
--предложите перечень запросов для решения данной задачи
set identity_insert UsedCars ON
insert into UsedCars (reg_code) values (20180001)

set identity_insert UsedCars OFF
delete from usedcars where reg_code = '20180001'
--a. Вставьте мин. 3 записи (машины другой марки (4))
select * from UsedCars
Insert UsedCars (mark, model, release_year, price) values ('Toyota', 'Yaris', '2020', '19900')
Insert UsedCars (mark, model, release_year, price) values ('Toyota', 'RAV4', '2019', '31900')
Insert UsedCars (mark, model, release_year, price) values ('Toyota', 'Corolla', '2011', '5000')

--8. Создайте первичный ключ в т. по коду регистрации машины
ALTER TABLE UsedCars ADD CONSTRAINT PK_UsedCars PRIMARY KEY(reg_code)

--9. Понизьте цену машин, которые самые старые (по дате выпуска) - UPDATE
update UsedCars set price = price * 0.9
where release_year in (select min(release_year) from UsedCars)

--10.Создайте таблицу (2) покупатель, поля (личный код, имя, фамилия, майл, телефон),
--ключевое поле - личный код, поле фамилия обязательное для заполнения
Create table Customer (
id_code char(11),
name varchar(20),
surname varchar(20) not null,
mail varchar(40),
phone char(20),
CONSTRAINT PK_Customer PRIMARY KEY(id_code)
);
--a. Вставьте мин. 2 покупателя
select * from Customer
insert customer (id_code, name, surname, mail, phone)
values (50103273728,'Maxim', 'Kolesnikov', 'maksim.kolesnikov@ivkhk.ee', '+37258007334')

insert customer (id_code, name, surname, mail, phone)
values (50103275614,'Sergei', 'Komarov', 'sergei.komarov@ivkhk.ee', '+37258957424')

--11.Создайте таблицу (3) владельцы и их машины, поля (код регистрации машины, личный
--код покупателя, дата регистрации сделки – значение по умолчанию текущая дата и время),
--ключевое поле - код регистрации машины и личный код покупателя
Create table OwnersAndCars (
reg_code int,
id_code char(11),
deal_date date default getdate(),
CONSTRAINT PK_OwnersAndCars PRIMARY KEY(reg_code, id_code)
);
drop table OwnersAndCars
--a. Вставьте мин.3 записи в таблицу
select * from OwnersAndCars
select * from UsedCars
insert OwnersAndCars values (20170001, 50103273728, getdate())
insert OwnersAndCars values (20170002, 50103273728, getdate())
insert OwnersAndCars values (20170003, 50103275614, getdate())

--12. Обновите статус у проданной машины, если она получила владельца (т.е. она продана)
update UsedCars set status = 'No' 
where exists (select * from OwnersAndCars
					where OwnersAndCars.reg_code = UsedCars.reg_code);

select * from UsedCars

--13.Создайте связь между таблицами: машины и их владельцы (3) и машины (1)
ALTER TABLE OwnersAndCars ADD CONSTRAINT fk_reg_code FOREIGN KEY (reg_code) REFERENCES UsedCars(reg_code);

--14.Создайте связь между таблицами: машины и их владельцы (3) и покупатели (2)
ALTER TABLE OwnersAndCars ADD CONSTRAINT fk_id_code FOREIGN KEY (id_code) REFERENCES Customer(id_code);
