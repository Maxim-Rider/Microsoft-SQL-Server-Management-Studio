Use WholeSale

--1. ���������� ���������� ������� ����������� � 1996 ���� 
select count(orderid) as QuantityOrders from orders
where YEAR(orderdate) = 1996

--2. ���������� � ����� ������ ���� ����������� ������ � ������� 
--������� ���� ����������� � ������ �� ����� 
select shipcountry, count(orderid) as QuantityOrdersToCountry from orders
group by ShipCountry

--3. �������� 7 �������, � ������� ���� ����� ������� ��������, ������� 
--��� ������, ��� �������, ������ � ��������� ��������
select top 7 orderid, customerid, shipcountry, unitprice from orders, products
where unitprice = 
(select max(unitprice) from orders, products)

--4. ����� ������������ ���������� ������� ���� ��������� ����� ��
--����������� (��� ����� ���������� ���� �� �����)
select top 1 customerid, max(quantity) as MaxOrders from orders, orderdetails
group by customerid

--5. ����������� ���������� �������, � ������� ������������� ���� ��������
select count(orderid) as QuantityWithNull from orders
where shippeddate is null
group by shippeddate

--6. ������� ������� ������� ������ �� ��������, ������������ � ������� �����������
select customerid, count(orderid) as BoughtOrders from orders
group by customerid

--7. �������� ��������, ������� �������� ����� 15 �������,
--������������ ������ � ������� �������� ���������� ����������� �������
select orderid as Customers_Order from orders
where orderid > 15 
group by orderid
order by orderid desc 

--8. �� ����� ����� � �� ����� ������� � ��� 2 � ����� ��������
select count(city) as CustomersQuantity 
from customers 
group by city

