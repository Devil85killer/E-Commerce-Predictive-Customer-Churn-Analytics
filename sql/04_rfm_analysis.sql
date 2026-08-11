USE ecommerce;
GO

-- Calculate base RFM metrics per unique customer
SELECT
    customer_unique_id,
    DATEDIFF(DAY, MAX(order_purchase_timestamp), MAX(MAX(order_purchase_timestamp)) OVER ()) AS recency,
    COUNT(DISTINCT order_id) AS frequency,
    SUM(total_order_value) AS monetary
INTO dbo.Customer_RFM
FROM dbo.Customer_Transactions
GROUP BY customer_unique_id;
GO