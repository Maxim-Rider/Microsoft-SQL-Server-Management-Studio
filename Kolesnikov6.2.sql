Use WholeSale

--1. Определите количество заказов оформленных в 1996 году 
select count(orderid) as QuantityOrders from orders
where YEAR(orderdate) = 1996

--2. Определите в какие страны были доставленны заказы и сколько 
--заказов было доставленно в каждую из стран 
select shipcountry, count(orderid) as QuantityOrdersToCountry from orders
group by ShipCountry

--3. Выберите 7 заказов, у которых была самая дорогая доставка, укажите 
--код заказа, код клиента, страну и стоимость доставки
select top 7 orderid, customerid, shipcountry, unitprice from orders, products
where unitprice = 
(select max(unitprice) from orders, products)

--4. Какое максимальное количество заказов было оформлено одним из
--сотрудников (имя этого сотрудника пока не важно)
select top 1 customerid, max(quantity) as MaxOrders from orders, orderdetails
group by customerid

--5. Подсчитайте количество заказов, у которых отсутствовала дата доставки
select count(orderid) as QuantityWithNull from orders
where shippeddate is null
group by shippeddate

--6. Сколько заказов оформил каждый из клиентов, отсортируйте в порядке возрастания
select customerid, count(orderid) as BoughtOrders from orders
group by customerid

--7. Выберите клиентов, которые оформили более 15 заказов,
--отсортируете данные в порядке убывания количества оформленных заказов
select orderid as Customers_Order from orders
where orderid > 15 
group by orderid
order by orderid desc 

--8. Из каких стран и из каких городов у нас 2 и более клиентов
select count(city) as CustomersQuantity 
from customers 
group by city

