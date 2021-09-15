/*
15.1 �������������� ��������� ���� ������ "���������� ������������"
�����: ������ ����������
����: 02.06.2021
*/
--1. �������� ���� ������
Create database Apartment_Partnership
Use Apartment_Partnership
--2. ���������� ��������� ������� ��� ����� ���������� ������ � ������ ��������
create table Apartment (
apartment_number int not null primary key,
area_square_meter float not null,
heating varchar(30) not null, -- ��� ���������
heating_percent int not null,
owner_idcode char(11) null,
owner_name varchar(30) null,
owner_phone varchar(30) null
)
--3. ���������� ��������� ������ ������� ��� ������������:
--��������� ������� 1�2
create table PriceForArea (
beginning_date date not null primary key, --����� ������� ������
price money not null, --����� �� �� �
date_of_approval date not null, --���� �����������
approver varchar(30) not null default 'Elena Petrova' --�����������
)
--��������� ������� ������������� �����
create table PriceForHeating (
beginning_date date not null primary key,
price money not null, -- ����� ���/�
date_of_approval date not null,
approver varchar(30) not null default 'Elena Petrova'
)
--4. ���������� ��������� ������� ��� ����� ��������� ��������� (���������� �������� �� ����������� ������������ ����������� �����)
create table MetersData (
last_day_of_date date not null primary key, --��������� ���� ������
data float not null, -- ��������� ��������
withdrawal_date date not null, -- ���� ������ ��������� ��������
withdrawer varchar(30) not null default 'Elena Petrova' -- ��� ���� ���������
)
--6. ������� ������ � ������������� ������ ����������
insert into Apartment values (1, 50.2, 'central', 100, '50103273728', 'Maxim Kolesnikov', '+37258007334')
insert into Apartment values (2, 47.4, 'gas', 10, '50305300218', 'Viktor Pomokalov', '+37256284592')
insert into Apartment values (3, 42.8, 'electric', 15, '36005305010', 'Sergei Ivanov', '+37258615248')

insert into PriceForArea values ('01-01-2021', 0.61, '20-11-2020', default)

insert into PriceForHeating values ('01-01-2021', 63.26, '20-11-2020', default)
delete from PriceForHeating
insert into MetersData values (eomonth('30-12-2020'), 35.287, '30-12-2020', default)
--insert into MetersData values (eomonth('28-01-2021'), 50.287, '28-01-2021', default)
delete from MetersData

select * from Apartment
select * from PriceForArea
select * from PriceForHeating
select * from MetersData
--7. ���������� ������ ���������� ��������� ������������ ��� ������ �������� � ����������� �� ������ � � �������


---����� ��������������� �������.
declare @total float,
@current_data float,
@last_data float
set @last_data = (
select top 1 data from MetersData
order by last_day_of_date desc
)
select @last_data
set @current_data = 55
set @total = @current_data - @last_data
select @total
insert into MetersData values (eomonth('28-01-2021'), @current_data, '28-01-2021', default)
select * from MetersData


----
drop proc Total
go
create proc Total
@current_data float,
@withdrawal_date date
as
	begin
		declare @total float,
		@last_data float
		set @last_data = (
		select top 1 data from MetersData
		order by last_day_of_date desc
		)
		set @total = @current_data - @last_data
		select @total
		insert into MetersData values (eomonth(@withdrawal_date), @current_data, @withdrawal_date, default)
		declare @sum_area float,
		@price_for_mwh money,
		@price_for_area money,
		@sum_per_heating_m money
		set @sum_area = (select sum(area_square_meter*heating_percent/100) from Apartment)
		set @price_for_mwh = (select top 1 price from PriceForHeating order by beginning_date desc)
		set @price_for_area = (select top 1 price from PriceForArea order by beginning_date desc)
		set @sum_per_heating_m =  @price_for_mwh * @total / @sum_area


		select @sum_area, @price_for_area, @price_for_mwh, @sum_per_heating_m
	end
go
select * from MetersData
exec Total 58, '28-01-2021'

exec Total 68, '28-02-2021'

exec Total 75, '28-03-2021'

exec Total 76, '28-04-2021'

exec Total 100, '28-05-2021'

/*
declare @total float,
@current_data float,
@last_data float
set @last_data = (
select top 1 data from MetersData
order by last_day_of_date desc
)
select @last_data
set @current_data = 55
set @total = @current_data - @last_data
select @total
insert into MetersData values (eomonth('28-01-2021'), @current_data, '28-01-2021', default)
select * from MetersData
*/




--9. ���������� ������������ ������� ����� ����
select sum(area_square_meter*heating_percent/100) from Apartment

select top 1 price from PriceForArea
order by beginning_date desc
select top 1 price from PriceForHeating
order by beginning_date desc


--������� "� ������"
create table To_Pay (
payment_date date not null,
apartment_number int not null,
area float not null,
price_area_m money not null,
heating_price money not null,
heating_price_for_mwh money not null,
primary key (payment_date, apartment_number)
)
ALTER TABLE To_Pay ADD CONSTRAINT fk_apartment_number FOREIGN KEY (apartment_number) REFERENCES Apartment(apartment_number);
ALTER TABLE To_Pay ADD CONSTRAINT fk_payment_date FOREIGN KEY (payment_date) REFERENCES MetersData(last_day_of_date);