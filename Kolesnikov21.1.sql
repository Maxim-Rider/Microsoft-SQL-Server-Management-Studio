--Автор: Максим Колесников
--Дата: 28.05.2021
use WholeSale
--Выберите товары и определите на какую сумму у нас каждого товара на складе (Товары (Product))
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

/*2. Вычислите количество заказов, оформленных в определённом году (год
передаёте как входной параметр – четырёхзначное число), в процедуре
примените функции для обработки временных данных т.(Заказы (Orders)*/
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

--3. Определите на какую сумму товаров каждой категории у нас на складе т.(Товары (Product))
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
/*4. Процедура выводит список поставщиков (компания, страна) и их поставляемые продукты (код, название, цена). Страну передаёте как входной
параметр, для выборки поставщиков из определённой страны – текстовое
значение т. (Suppliers(Поставщики), Товары (Product))*/
