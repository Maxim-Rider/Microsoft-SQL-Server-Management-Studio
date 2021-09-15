Автор - Максим Колесников
Дата - 15.04.2021
Tema 10. SQL - DDL (Create Database, Create Table - основные свойства и параметры)

--1
Use master;

Create database projects
On (name=projects_dat,
Filename = 'E:/SQLDatabases/projects.mdf',
Size = 5,
Maxsize = 100,
Filegrowth = 5)
Log on
(Name = projects_log,
Filename = 'E:/SQLDatabases/projects.ldf',
Size = 10,
Maxsize = 100,
Filegrowth = 10);

--2
Use projects
Go
Create table product
(product_no integer identity(10000, 1) not null, product_name char(30) not null, price money);
Go

--3
Insert product (product_name, price) values ('piin',0.25)

Insert product (product_name, price) values ('koor',0.45)

Delete from product where productid = 105

--4
Drop table product

--############
Create table product
(product_no integer identity(10000, 1) not null primary key, product_name char(30) not null, product_count int default 1, price money, cur_date datetime default getdate(), ship_date date, check (ship_date > cur_date), constraint ch_pr_count check (product_count between 1 and 10) );
Go

Insert product (product_name, price) values ('koor',0.45)

Insert product (product_name, product_count, price) values ('hapukoor', 5, 1.15)

Insert product (product_name, product_count, price) values ('piin', default, 1.25)