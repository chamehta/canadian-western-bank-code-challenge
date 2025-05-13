/*----------DDL statement for the creation of star schema -----*/
CREATE TABLE [DimProduct] (
  [ProductID] INT
);

CREATE TABLE [FactOrderDetail] (
  [OrderDetailID] INT,
  [BusinessEntityID] INT,
  [OrderID] INT
  [ProductID] INT,
  [TerritoryID] INT,
  [OrderQty] INTEGER,
);

CREATE TABLE [DimOrder] (
  [OrderID] INT,
  [OrderDate] DATE
);

CREATE TABLE [DimTerritory] (
  [TerritoryID] INT,
  [TerritoryName] NVARCHAR(100)
);

CREATE TABLE [DimSalesEmployee] (
  [BusinessEntityID] INT,
  [FirstName] NVARCHAR(100),
  [LastName] NVARCHAR(100),
  [JobTitle] NVARCHAR(100)
);


CREATE TABLE [FactSales] (
  [BusinessEntityID] INT,
  [TerritoryID] INT,
  [SalesYTD] DECIMAL(24,4)
);

/*-------------- StoredProcedurePart2a-----------------*/
CREATE PROCEDURE GetDataForMlAlgorithm   
AS   
    SELECT 
   		  DP.ProductID
		 ,DO.OrderID
		 ,DSE.FirstName
		 ,DSE.LastName
 		 ,DO.OrderDate
		 ,DT.TerritoryID
         ,FOD.OrderQty AS SalesOrderQty
    FROM [FactOrderDetail] as FOD
    LEFT OUTER JOIN [DimTerritory] AS DT
    ON FOD.TerritoryID = DT.TerritoryID
    LEFT OUTER JOIN [DimOrder] DO
    ON FOD.OrderID = DO.OrderID
    LEFT OUTER JOIN [DimProduct] AS DP 
    ON DO.ProductID = DP.ProductID
    LEFT OUTER JOIN [DimSalesEmployee] AS DSE 
    ON FOD.BusinessEntityID = DSE.BusinessEntityID; 

/*---------- StoredProcedurePart2b---------------------*/
CREATE PROCEDURE  GetDataForManagementReport
    @Territory nvarchar(50),   
    @GroupofSalesPeople nvarchar(5000)   ---pass a single comma delimiter string to the stored procedure
AS   
DECLARE @Sql VARCHAR(MAX)
SET @GroupofSalesPeople = REPLACE(@GroupofSalesPeople,',',''',''')
 
SET @Sql = '
      SELECT   
         SDT.TerritoryID
        ,DSP.JobTitle
        ,DSP.FirstName AS SalesPersonFirstName
        ,DSP.LastName AS SalesPersonLastName
        ,FS.SalesYTD
      FROM [FactSales] AS FS 
      LEFT OUTER JOIN [DimSalesPerson] AS DSP
      ON FS.BusinessEntityID = DSP.BusinessEntityID
      LEFT OUTER JOIN [DimTerritory] AS DT
      ON DSP.TerritoryID = DT.TerritoryID
      WHERE DSP.TerritoryName = @Territory
      AND CONCAT(DSP.FirstName, ' ', DSP.LastName) IN (
      ''' + @GroupofSalesPeople + '''
       )
      ORDER BY FS.BusinessEntityID'
 
EXEC (@Sql)


/*------------Impressive Bonus assignment------*/
--PercentOfTotal column
SELECT 
     BusinessEntityID
    ,SalesYTD
    ,(SalesYTD * 100.0 / (SELECT SUM(SalesYTD) FROM [FactSale])) AS PercentOfTotal
FROM [FactSale]
GROUP BY BusinessEntityID;

--Rank by sales column
SELECT
     BusinessEntityID,
     SalesYTD,
     DENSE_RANK ( ) OVER ( ORDER BY SalesYTD DESC, BusinessEntityID ASC ) AS Rank  
FROM FactSales;