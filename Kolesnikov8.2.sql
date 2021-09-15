use WholeSale

--1. ���������� �������� ������, � ���� �� ����������� � �� ����� �����?
select CompanyName, Country 
from products inner join Suppliers on
products.supplierid = suppliers.SupplierID
where Discontinued = '1';

--2. �� ����� ����� ���������� �������?
select Country, CategoryName
from Categories inner join Suppliers on
Categories.categoryid = suppliers.SupplierID
where CategoryName = 'produce'

--3. �� ����� �����, � �� ����� ����� �����, ������� ������� ���� �������?
select companyname, country, sum(unitprice) * UnitsOnOrder as Summa
from products p inner join suppliers s on
s.supplierid = p.supplierid
group by CompanyName, country, unitprice, UnitsOnOrder

--4. �� ����� ����� c������ ������� ��������?

--� ����������


--5. �������� ������, ������� ������� ������ � ��������� � ����������� �����.
select * from products
where unitprice in
	(select min(unitprice) 
	from products)

--6. ������ ���������� ����������� (��������, ������, �����) �� ������
--(Japan) � �������� (���, ��������, ����), ������� ��� ����������.
select companyname, country, city, productid, productname, unitprice
from products p inner join suppliers s on
s.supplierid = p.supplierid
where s.country = 'Japan';

--7. �������� ������, ������� ������� ������ � ��������, �� ����������� ������ 12 ������� 2007 �.
select * from customers c
where not exists 
	(select * from orders o
	where c.customerid = o.customerid
	and requireddate = '2007-02-12')

--8. �������� ������, ������� ������� ������ � �������� � ���������� ��
--����������� �������. ������������ �� ����� ����������� ������� � ������� ��������.

select CustomerID, count(orderid) as count from orders
group by CustomerID
order by count(orderid) desc

--9. �������� ������, ������� ������� ������ � ��������, ������� ��
--��������� �� ������ ������.
select * from Customers
where not exists
	(select CustomerID from Orders 
	where Customers.CustomerID = Orders.CustomerID)

--10. ���������� ������, ������� ������� ������ � �������, ������� ��
--������������ � 2007 ����.
select *
from OrderDetails
right join Orders on OrderDetails.ProductID = Orders.OrderID 
where year(orderdate) != 2007

--11. ������ ������ �������� ���� �������� �� ��� (USA) � ������� ���
--������� �� ��� ���������� ��������� ������� � �� ����� ���������.
--������������ ������� Customers, Orders � OrderDetails.
select companyname, count(orderid), sum(unitprice) * UnitsOnOrder as Summa from products p 
inner join suppliers s on
s.supplierid = p.supplierid 
inner join orders o on
p.supplierid = o.orderid
where country = 'USA'
group by CompanyName, country, unitprice, UnitsOnOrder
order by count(orderid)

