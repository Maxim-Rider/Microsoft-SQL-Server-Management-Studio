--�����: ������ ����������
--����: 04.05.2021
--11.3 ������ "���������� SQL ��������, ��������� DDL - ���� ������ AUTOD"

--1. �������� ���� ������ (����������� ����������� �����)
CREATE DATABASE Kolesnikov11_3;
Use Kolesnikov11_3

--2. �������� ������� (1) - (�����������), ���� (�����, ������, ��� �������, ����,
--������ (� �������/��� ������� � Yes/No, �� ��������� Yes, ��� 1/0 �� ��������� 1))
Create table UsedCars (
mark varchar(20),
model varchar(20),
release_year char(4),
price money,
status varchar(20) default 'Yes',
check (status in('Yes','No'))
);
--a. �������� ���. 3 ������ (������ ����� ����� (1)) � ������ INSERT �
select * from UsedCars
Insert UsedCars (mark, model, release_year, price) values ('Audi', 'R8', '2020', '165000')
Insert UsedCars (mark, model, release_year, price) values ('Audi', 'RS7', '2015', '55000')
Insert UsedCars (mark, model, release_year, price) values ('Audi', 'Q7', '2006', '7200')

--3. �������� ��������� �������, �������� � ������� (1) ���� � ��������� ������, �� ���������
--�� ��������� (��������: �������)
Alter table UsedCars add condition varchar(20) default 'good'

--a. �������� ���. 2 ������ (������ ������ ����� (2))
select * from UsedCars
Insert UsedCars (mark, model, release_year, price) values ('BMW', 'i8', '2018', '77000')
Insert UsedCars (mark, model, release_year, price) values ('BMW', 'X6', '2008', '12000')
Insert UsedCars (mark, model, release_year, price) values ('BMW', 'M3', '2009', '22900')

--4. �������� ��� ������ � ���� ��������� ������ (��������: ��������� ��� ��������� �����
--����, �������� ��� ������ char ��� varchar)
Alter table UsedCars alter column condition varchar(30)


--a. �������� ���. 1 ������ (������ ��� �� ����� (2))
Insert UsedCars (mark, model, release_year, price) values ('BMW', 'M6', '2013', '52860')

--5. �������� �������� �� ��������� ���� ��������� ������ (��������: ��������)
alter table UsedCars drop constraint DF__UsedCars__condit__59063A47
go
alter table UsedCars add constraint DF__UsedCars__condit__59063A47 default 'great' for condition

--�������� ��� �����������
exec sp_helpconstraint UsedCars


--a. �������� ���. 2 ������ (������ ������ ����� (3))
select * from UsedCars
Insert UsedCars (mark, model, release_year, price) values ('Honda', 'Civic', '2021', '26300')
Insert UsedCars (mark, model, release_year, price) values ('Honda', 'CR-V', '2019', '34890')

--6. �������� � ������� (1) ���� ��� ����������� ������, ��������������� ����, � ���������
--�������� �������� ������� ��� � ����� ����������� (��������: 20170001)
Alter table UsedCars add reg_code int identity (20170001, 1)

--a. �������� ���. 1 ������ (������ ��� �� ����� (3))
select * from UsedCars
Insert UsedCars (mark, model, release_year, price) values ('Honda', 'Accord', '2014', '12100')

--7. ����� ��� ���������� � ��������� ���� ����������� (��������: 20180001),
--���������� �������� �������� ��� ������� ������ ������
set identity_insert UsedCars ON
insert into UsedCars (reg_code) values (20180001)

set identity_insert UsedCars OFF
delete from usedcars where reg_code = '20180001'
--a. �������� ���. 3 ������ (������ ������ ����� (4))
select * from UsedCars
Insert UsedCars (mark, model, release_year, price) values ('Toyota', 'Yaris', '2020', '19900')
Insert UsedCars (mark, model, release_year, price) values ('Toyota', 'RAV4', '2019', '31900')
Insert UsedCars (mark, model, release_year, price) values ('Toyota', 'Corolla', '2011', '5000')

--8. �������� ��������� ���� � �. �� ���� ����������� ������
ALTER TABLE UsedCars ADD CONSTRAINT PK_UsedCars PRIMARY KEY(reg_code)

--9. �������� ���� �����, ������� ����� ������ (�� ���� �������) - UPDATE
update UsedCars set price = price * 0.9
where release_year in (select min(release_year) from UsedCars)

--10.�������� ������� (2) ����������, ���� (������ ���, ���, �������, ����, �������),
--�������� ���� - ������ ���, ���� ������� ������������ ��� ����������
Create table Customer (
id_code char(11),
name varchar(20),
surname varchar(20) not null,
mail varchar(40),
phone char(20),
CONSTRAINT PK_Customer PRIMARY KEY(id_code)
);
--a. �������� ���. 2 ����������
select * from Customer
insert customer (id_code, name, surname, mail, phone)
values (50103273728,'Maxim', 'Kolesnikov', 'maksim.kolesnikov@ivkhk.ee', '+37258007334')

insert customer (id_code, name, surname, mail, phone)
values (50103275614,'Sergei', 'Komarov', 'sergei.komarov@ivkhk.ee', '+37258957424')

--11.�������� ������� (3) ��������� � �� ������, ���� (��� ����������� ������, ������
--��� ����������, ���� ����������� ������ � �������� �� ��������� ������� ���� � �����),
--�������� ���� - ��� ����������� ������ � ������ ��� ����������
Create table OwnersAndCars (
reg_code int,
id_code char(11),
deal_date date default getdate(),
CONSTRAINT PK_OwnersAndCars PRIMARY KEY(reg_code, id_code)
);
drop table OwnersAndCars
--a. �������� ���.3 ������ � �������
select * from OwnersAndCars
select * from UsedCars
insert OwnersAndCars values (20170001, 50103273728, getdate())
insert OwnersAndCars values (20170002, 50103273728, getdate())
insert OwnersAndCars values (20170003, 50103275614, getdate())

--12. �������� ������ � ��������� ������, ���� ��� �������� ��������� (�.�. ��� �������)
update UsedCars set status = 'No' 
where exists (select * from OwnersAndCars
					where OwnersAndCars.reg_code = UsedCars.reg_code);

select * from UsedCars

--13.�������� ����� ����� ���������: ������ � �� ��������� (3) � ������ (1)
ALTER TABLE OwnersAndCars ADD CONSTRAINT fk_reg_code FOREIGN KEY (reg_code) REFERENCES UsedCars(reg_code);

--14.�������� ����� ����� ���������: ������ � �� ��������� (3) � ���������� (2)
ALTER TABLE OwnersAndCars ADD CONSTRAINT fk_id_code FOREIGN KEY (id_code) REFERENCES Customer(id_code);
