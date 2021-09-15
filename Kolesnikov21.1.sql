--�����: ������ ����������
--����: 28.05.2021
use WholeSale
--�������� ������ � ���������� �� ����� ����� � ��� ������� ������ �� ������ (������ (Product))
create proc SummaPerProduct
@productid int
as
	begin
		select productid, unitprice * UnitsInStock as Summa
		from Products
			where productid = @productid
	end

exec SummaPerProduct
@productid = '1'

/*2. ��������� ���������� �������, ����������� � ����������� ���� (���
�������� ��� ������� �������� � ������������� �����), � ���������
��������� ������� ��� ��������� ��������� ������ �.(������ (Orders)*/
create proc ProductsQuantityInYear
@order_id_from as varchar(5) = '10000',
@order_id_to as varchar(5) = '99999',
@orderdate_from as date = '1996',
@orderdate_to as date = '1998'
as
	begin
		select orderid, customerid, orderdate
			from orders
				where orderid >= @order_id_from
					and orderid < @order_id_to
					and orderdate >= @orderdate_from
					and orderdate < @orderdate_to
	end

exec ProductsQuantityInYear
@order_id_from = '10000',
@order_id_to = '99999',
@orderdate_from = '1996',
@orderdate_to = '1997'

--3. ���������� �� ����� ����� ������� ������ ��������� � ��� �� ������ �.(������ (Product))
create proc SummaPerCategory
@categoryid int
as
	begin
		select CategoryID, unitprice * UnitsInStock as Summa
		from Products
			where categoryid = @categoryid
	end

exec SummaPerCategory
@categoryid = '1'
/*4. ��������� ������� ������ ����������� (��������, ������) � �� ������������ �������� (���, ��������, ����). ������ �������� ��� �������
��������, ��� ������� ����������� �� ����������� ������ � ���������
�������� �. (Suppliers(����������), ������ (Product))*/
