1. Выберите заказчиков из Германии, Франции и Мадрида, выведите их название, страну и адрес.

SELECT CustomerName, Country, Address FROM Customers
WHERE Customers.Country = "Germany" or Customers.Country = "France" or Customers.City = "Madrid"

2. Выберите топ 3 страны по количеству заказчиков, выведите их названия и количество записей.

SELECT Country, count(CustomerName) as Count FROM Customers
GROUP BY Country ORDER BY Count DESC LIMIT 3

3. Выберите перевозчика, который отправил 10-й по времени заказ, выведите его название, и дату отправления.

SELECT ShipperName, OrderDate FROM Orders
INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID LIMIT 1 OFFSET 9

4. Выберите самый дорогой заказ, выведите список товаров с их ценами.

SELECT ProductName, Price FROM (
SELECT OrderID, sum(OrderDetails.Quantity * Products.Price) as Sum FROM ((Orders
JOIN OrderDetails USING(OrderID))
JOIN Products USING(ProductID))
GROUP BY OrderID ORDER BY Sum DESC LIMIT 1)
JOIN OrderDetails USING(OrderID)
JOIN Products USING(ProductID)


5. Какой товар больше всего заказывали по количеству единиц товара, выведите его название и количество единиц в каждом из заказов.

SELECT ProductName, OrderID, Quantity FROM (
SELECT ProductID, sum(Quantity) as SUM FROM (Orders
JOIN OrderDetails USING(OrderID))
GROUP BY ProductID ORDER BY SUM DESC LIMIT 1)
JOIN Products USING(ProductID)
JOIN OrderDetails USING(ProductID)

6. Выведите топ 5 поставщиков по количеству заказов, выведите их названия, страну, контактное лицо и телефон.

Select SupplierName, Country, ContactName, Phone FROM (
SELECT SupplierID, count(OrderID) as Count FROM ((Orders
JOIN OrderDetails USING(OrderID))
JOIN Products USING(ProductID))
GROUP BY CategoryID ORDER BY Count DESC LIMIT 5)
JOIN Suppliers USING(SupplierID)

7. Какую категорию товаров заказывали больше всего по стоимости в Бразилии, выведите страну, название категории и сумму.

SELECT Country, CategoryName, sum(Price * Quantity) as Sum FROM Orders
JOIN Customers USING(CustomerID)
JOIN OrderDetails USING(OrderID)
JOIN Products USING(ProductID)
JOIN Categories USING(CategoryID)
WHERE Country = "Brazil"
GROUP BY CategoryName ORDER BY Sum DESC LIMIT 1

8. Какая разница в стоимости между самым дорогим и самым дешевым заказом из США.

SELECT max(Sum) - min(Sum) as Difference FROM
(SELECT OrderID, sum(Quantity * Price) AS Sum  FROM Orders
JOIN Customers USING(CustomerID)
JOIN OrderDetails USING(OrderID)
JOIN Products USING(ProductID)
WHERE Country = "USA"
GROUP BY OrderID)

9. Выведите количество заказов у каждого их трех самых молодых сотрудников, а также имя и фамилию во второй колонке.

SELECT count(OrderID) as Count, (Employees.FirstName || ' ' || Employees.LastName) AS FullName FROM Orders
JOIN Employees USING(EmployeeID)
GROUP BY EmployeeID ORDER BY BirthDate DESC LIMIT 3

10. Сколько банок крабового мяса всего было заказано.

SELECT sum(Quantity) as Sum FROM Orders
JOIN OrderDetails USING(OrderID)
JOIN Products USING(ProductID)
WHERE ProductName = "Boston Crab Meat"
