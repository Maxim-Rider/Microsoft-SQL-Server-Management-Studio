use WholeSale;

--1. Выберите клиентов, у которых страна Канада

select ContactName, Country from customers
where country = 'Canada';

--2. Выберите клиентов, у которых почтовый код 1010 или 8010

select ContactName, PostalCode from customers
where postalcode = '1010' or postalcode = '8010';

--3. Выберите клиентов, у которых отсутствует факс

select ContactName, fax from customers
where fax is null;

--4. Выберите клиентов, у которых указан регион

select contactname, region from customers
where region is not null;

--5. Выберите клиентов, у которых не указан регион и отсутствует факс

select contactname, region, fax from customers
where region is null and fax is null;

--6. Выберите клиентов, у которых в телефоне присутствуют три пятёрки: 555

select contactname, phone from customers
where phone like '%555%'

--7. Выберите клиентов, у которых должность владелец (owner) и страна Мехико или Америка

select contactname, contacttitle, country from customers
where contacttitle = 'owner' and (country = 'Mexico' or country = 'USA')

--8. Выберите клиента с именем Sven

select contactname from customers
where contactname like 'Sven%'

--9. Из каких стран наши клиенты?

select distinct country from customers

--10.Выберите клиентов, у которых кодклиента начинается на буквы B, C, D или E

select contactname, customerid from customers
where customerid like 'b%'
or customerid like 'c%'
or customerid like 'd%'
or customerid like 'e%'

--11.Выберите клиентов, у которых кодклиента не заканчивается на букву A или O
select contactname, customerid from customers
where customerid not like '%a' and customerid not like '%o'

--12.Выберите клиентов, у которых в должности контактного лица есть sales

select contactname, contacttitle from customers
where contacttitle like 'sales%'

--13.Выберите клиентов, у которых в должности контактного лица manager, но не sales
select contactname, contacttitle from customers
where contacttitle not like 'sales' and contacttitle like '%manager'

--14.Выберите клиентов, у которых в названии города 3 слова (например: Rio de Janeiro)
select contactname, city from customers
where city like '% % %'

--15.Выберите заказы, оформленные в 96 году
select orderid, orderdate from orders
where YEAR(orderdate) = 1996

--16.Выберите заказы, оформленные в августе 97 года
select orderid, orderdate from orders
where year(orderdate) = 1997 and month(orderdate) = 08

--17.Выберите заказы, оформленные в июле 97 года для фирмы GREAL
select orderid, orderdate, companyname from orders, customers
where year(orderdate) = 1997 and month(orderdate) = 07 and companyname = 'Great Lakes Food Market'

--18.Выберите товары, стоимость которых больше 50 и на складе осталось меньше 5

select productid, unitprice, quantity from OrderDetails
where unitprice > 50 and quantity < 5

--19.Выберите товары и определите на какую сумму у нас каждого товара на складе

select distinct productid, unitprice * quantity as Summa from OrderDetails

--20.Выберите первые 4 заказа оформленные в базе данных

select top 4 * from orders
