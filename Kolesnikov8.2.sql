use WholeSale

--1. Прекращены поставки товара, у кого из поставщиков и из каких стран?
select CompanyName, Country 
from products inner join Suppliers on
products.supplierid = suppliers.SupplierID
where Discontinued = '1';

--2. Из каких стран поставщики фруктов?
select Country, CategoryName
from Categories inner join Suppliers on
Categories.categoryid = suppliers.SupplierID
where CategoryName = 'produce'

--3. Из каких стран, и на какую общую сумму, сделали заказов наши клиенты?
select companyname, country, sum(unitprice) * UnitsOnOrder as Summa
from products p inner join suppliers s on
s.supplierid = p.supplierid
group by CompanyName, country, unitprice, UnitsOnOrder

--4. На какую сумму cделали заказов ежегодно?

--в разработке


--5. Создайте запрос, который выводит данные о продуктах с минимальной ценой.
select * from products
where unitprice in
	(select min(unitprice) 
	from products)

--6. Запрос возвращает поставщиков (компания, страна, город) из Японии
--(Japan) и продукты (код, название, цена), которые они поставляют.
select companyname, country, city, productid, productname, unitprice
from products p inner join suppliers s on
s.supplierid = p.supplierid
where s.country = 'Japan';

--7. Создайте запрос, который выводит данные о клиентах, не выполнивших заказы 12 февраля 2007 г.
select * from customers c
where not exists 
	(select * from orders o
	where c.customerid = o.customerid
	and requireddate = '2007-02-12')

--8. Создайте запрос, который выводит данные о клиентах и количество их
--оформленных заказов. Отсортируйте по числу выполненных заказов в порядке убывания.

select CustomerID, count(orderid) as count from orders
group by CustomerID
order by count(orderid) desc

--9. Создайте запрос, который выводит данные о клиентах, которые не
--оформляли ни одного заказа.
select * from Customers
where not exists
	(select CustomerID from Orders 
	where Customers.CustomerID = Orders.CustomerID)

--10. Предложите запрос, который выводит данные о товарах, которые не
--заказывались в 2007 году.
select *
from OrderDetails
right join Orders on OrderDetails.ProductID = Orders.OrderID 
where year(orderdate) != 2007

--11. Запрос должен отобрать всех клиентов из США (USA) и вернуть для
--каждого из них количество сделанных заказов и их общая стоимость.
--Используются таблицы Customers, Orders и OrderDetails.
select companyname, count(orderid), sum(unitprice) * UnitsOnOrder as Summa from products p 
inner join suppliers s on
s.supplierid = p.supplierid 
inner join orders o on
p.supplierid = o.orderid
where country = 'USA'
group by CompanyName, country, unitprice, UnitsOnOrder
order by count(orderid)

