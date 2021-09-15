--����: 26.05.2021
--�����: ������ ����������
--�������: 25 �����.

use WholeSale

GO
CREATE VIEW TotalSales
AS
select year(orderdate) as OrderYear, Customers.CompanyName as CustomerCompany, Shippers.CompanyName as ShipCompany, sum(quantity) as Quantity, sum(UnitPrice * Quantity) as Summa 
from Orders join OrderDetails on 
Orders.OrderID = OrderDetails.OrderID join
Customers on Orders.CustomerID = Customers.CustomerID join
Shippers on Orders.ShipVia = Shippers.ShipperID 
group by year(orderdate), Customers.CompanyName, Shippers.CompanyName
GO
--������, ������� ���������� ��������� ���������� � ����� ����� ������ ��� ���� ������, �� ����, �� ������� � �� ����������������
SELECT orderyear, CustomerCompany, ShipCompany, Quantity, Summa FROM TotalSales
ORDER BY orderyear, CustomerCompany, ShipCompany


---------
drop view TotalSales
