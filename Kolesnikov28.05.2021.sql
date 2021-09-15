--�����: ������ ����������
--����: 28.05.2021
--���� 21. �������� ��������� 

use WholeSale
--������ �������� �� ������� � �������� �������� ���������
select orderid, customerid, orderdate
from orders
where customerid = 'HANAR'
and orderdate >= '1998-04-01'
and orderdate < '1998-07-01'

-- ��������� ��� ���������� � ����������� ����
--���������� �������� ����� ����������� �������
declare @cust_id as varchar(5),
@orderdate_from as date,
@orderdate_to as date
	set @cust_id = 'HANAR'
	set @orderdate_from = '1998-04-01'
	set @orderdate_to = '1998-07-01'
		select orderid, customerid, orderdate
			from orders
				where customerid = @cust_id
					and orderdate >= @orderdate_from
					and orderdate < @orderdate_to
--������ �������� ���������:
create proc Get_CustomerOrders
@cust_id as varchar(5),
@orderdate_from as date = '19960101',
@orderdate_to as date = '20001231'
as
	begin
		select orderid, customerid, orderdate
			from orders
				where customerid = @cust_id
					and orderdate >= @orderdate_from
					and orderdate < @orderdate_to
	end
go
--����� ���������:
--1
exec Get_CustomerOrders 'Hanar'
--2
exec Get_CustomerOrders
@cust_id = 'Hanar'
--3
exec Get_CustomerOrders
'HANAR', '19980401', '19980701'
--4
exec Get_CustomerOrders
@cust_id = 'Hanar',
@orderdate_from = '19980401',
@orderdate_to = '19980701'
--�������� ���������� OUTPUT, �������
--���- �� ������������ �������
create proc Get_CustomerOrders
@custid varchar(5),
@orderdate_from date = '19960101',
@orderdate_to date = '20001231',
@numrows int = 0 output -- ����� ������������ �������
as
begin
	set nocount on
		select orderid, customerid, orderdate
		from orders
			where customerid = @custid
			and orderdate >= @orderdate_from
			and orderdate < @orderdate_to
	set @numrows = @@ROWCOUNT
end


