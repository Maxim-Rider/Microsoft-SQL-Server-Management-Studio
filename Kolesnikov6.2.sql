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
select customerid, count(orderid) as BoughtOrders from orders
group by customerid
having count(orderid) > 15
order by count(orderid) desc


--8. �� ����� ����� � �� ����� ������� � ��� 2 � ����� ��������
select country, city, count(customerid) as QuantityCustomers from customers 
group by country, city
having count(customerid) >= 2

--9. ������� �������������� ������� � ������ ��������� 
select categoryid, count(productid) as QuantitiesEachCategories from Products
group by categoryid

--10. �� ����� ����� ������� ������ ��������� � ��� �� ������
--(���������� ��������� � ���������� ������ �� ������)

select categoryid, sum(unitprice) * unitsinstock as SUMMA
from Products
group by categoryid, unitsinstock
order by categoryid asc