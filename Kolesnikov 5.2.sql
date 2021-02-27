use WholeSale;

--1. �������� ��������, � ������� ������ ������

select ContactName, Country from customers
where country = 'Canada';

--2. �������� ��������, � ������� �������� ��� 1010 ��� 8010

select ContactName, PostalCode from customers
where postalcode = '1010' or postalcode = '8010';

--3. �������� ��������, � ������� ����������� ����

select ContactName, fax from customers
where fax is null;

--4. �������� ��������, � ������� ������ ������

select contactname, region from customers
where region is not null;

--5. �������� ��������, � ������� �� ������ ������ � ����������� ����

select contactname, region, fax from customers
where region is null and fax is null;

--6. �������� ��������, � ������� � �������� ������������ ��� ������: 555

select contactname, phone from customers
where phone like '%555%'

--7. �������� ��������, � ������� ��������� �������� (owner) � ������ ������ ��� �������

select contactname, contacttitle, country from customers
where contacttitle = 'owner' and (country = 'Mexico' or country = 'USA')

--8. �������� ������� � ������ Sven

select contactname from customers
where contactname like 'Sven%'

--9. �� ����� ����� ���� �������?

select distinct country from customers

--10.�������� ��������, � ������� ���������� ���������� �� ����� B, C, D ��� E

select contactname, customerid from customers
where customerid like 'b%'
or customerid like 'c%'
or customerid like 'd%'
or customerid like 'e%'

--11.�������� ��������, � ������� ���������� �� ������������� �� ����� A ��� O
select contactname, customerid from customers
where customerid not like '%a' and customerid not like '%o'

--12.�������� ��������, � ������� � ��������� ����������� ���� ���� sales

select contactname, contacttitle from customers
where contacttitle like 'sales%'

--13.�������� ��������, � ������� � ��������� ����������� ���� manager, �� �� sales
select contactname, contacttitle from customers
where contacttitle not like 'sales' and contacttitle like '%manager'

--14.�������� ��������, � ������� � �������� ������ 3 ����� (��������: Rio de Janeiro)
select contactname, city from customers
where city like '% % %'

--15.�������� ������, ����������� � 96 ����
select orderid, orderdate from orders
where YEAR(orderdate) = 1996

--16.�������� ������, ����������� � ������� 97 ����
select orderid, orderdate from orders
where year(orderdate) = 1997 and month(orderdate) = 08

--17.�������� ������, ����������� � ���� 97 ���� ��� ����� GREAL
select orderid, orderdate, companyname from orders, customers
where year(orderdate) = 1997 and month(orderdate) = 07 and companyname = 'Great Lakes Food Market'

--18.�������� ������, ��������� ������� ������ 50 � �� ������ �������� ������ 5

select productid, unitprice, quantity from OrderDetails
where unitprice > 50 and quantity < 5

--19.�������� ������ � ���������� �� ����� ����� � ��� ������� ������ �� ������

select distinct productid, unitprice * quantity as Summa from OrderDetails

--20.�������� ������ 4 ������ ����������� � ���� ������

select top 4 * from orders
