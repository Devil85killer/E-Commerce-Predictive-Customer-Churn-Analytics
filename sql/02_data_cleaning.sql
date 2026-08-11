USE ecommerce;
GO

-- Create a view of valid, delivered orders
CREATE OR ALTER VIEW vw_clean_orders AS
SELECT *
FROM dbo.olist_orders_dataset
WHERE order_status = 'delivered' 
  AND order_purchase_timestamp IS NOT NULL;
GO