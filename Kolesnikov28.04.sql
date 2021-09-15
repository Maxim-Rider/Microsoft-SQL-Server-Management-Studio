--Дата 28.04.2021
--Максим Колесников
--Тема 11. SQL - DDL модифицирование объектов баз данных

use sample_primer
select * from employee

alter table employee add tel char(12) null;

alter table employee drop column tel

select * from department
alter table department
alter column location char(30) not null;

update department
set location = 'Tartu'
where location is null

drop table sales
create table sales
(orderID int identity (100,10) primary key,
order_date date not null,
ship_date date not null)

insert into sales (order_date, ship_date)
values ('20210428','2021-04-30')

select * from sales

alter table sales add constraint CK_date
check (order_date < ship_date)

alter table sales
drop constraint [PK_sales_0809337D2365F1A8]

alter table sales
add constraint PK_sales primary key (orderID)

