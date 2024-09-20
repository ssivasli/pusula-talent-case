
--Products tablosu oluşturma
CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName NVARCHAR(100),
Price DECIMAL(10, 2)
);


--Sales tablosu oluşturma
CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
ProductID INT,
Quantity INT,
SaleDate DATETIME,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


--Products verilen ürünleri ekleme
INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 1500.00),
(2, 'Mouse', 25.00),
(3, 'Keyboard', 45.00);


--Sales verileri ekleme
INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate) VALUES
(1, 1, 2, '2024-01-10'),
(2, 2, 5, '2024-01-15'),
(3, 1, 1, '2024-02-20'),
(4, 3, 3, '2024-03-05'),
(5, 2, 7, '2024-03-25'),
(6, 3, 2, '2024-04-12'); 

--Kontrol etme
SELECT * FROM Products
SELECT *FROM Sales


--Yıllık satış miktarını ve satış sayısını sorgulama
SELECT 
    p.ProductID,
    p.ProductName,
    YEAR(s.SaleDate) AS SaleYear,
    SUM(s.Quantity * p.Price) AS TotalSalesAmount,
    SUM(s.Quantity) AS TotalQuantity
FROM 
    Sales s
JOIN 
    Products p ON s.ProductID = p.ProductID
GROUP BY 
    p.ProductID, p.ProductName, YEAR(s.SaleDate)
ORDER BY 
    SaleYear, TotalSalesAmount DESC;


--Satış oranı en yüksek olan ürünü belirlemek
SELECT TOP 1
    p.ProductID,
    p.ProductName,
    SUM(s.Quantity * p.Price) AS TotalSalesAmount
FROM 
    Sales s
JOIN 
    Products p ON s.ProductID = p.ProductID
GROUP BY 
    p.ProductID, p.ProductName
ORDER BY 
    TotalSalesAmount DESC;
