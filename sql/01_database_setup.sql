USE ecommerce;
GO

-- Drop derived tables if they exist to allow clean rebuilds
IF OBJECT_ID('dbo.Customer_Churn_ML', 'U') IS NOT NULL DROP TABLE dbo.Customer_Churn_ML;
IF OBJECT_ID('dbo.Customer_Segments', 'U') IS NOT NULL DROP TABLE dbo.Customer_Segments;
IF OBJECT_ID('dbo.Customer_RFM', 'U') IS NOT NULL DROP TABLE dbo.Customer_RFM;
IF OBJECT_ID('dbo.Customer_Transactions', 'U') IS NOT NULL DROP TABLE dbo.Customer_Transactions;
GO