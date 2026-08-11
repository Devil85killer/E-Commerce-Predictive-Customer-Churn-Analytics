USE ecommerce;
GO

-- Build the master transaction table
SELECT
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    o.order_id,
    o.order_purchase_timestamp,
    p.total_order_value
INTO dbo.Customer_Transactions
FROM vw_clean_orders AS o
INNER JOIN dbo.olist_customers_dataset AS c 
    ON o.customer_id = c.customer_id
INNER JOIN (
    SELECT order_id, SUM(payment_value) AS total_order_value
    FROM dbo.olist_order_payments_dataset
    GROUP BY order_id
) AS p 
    ON o.order_id = p.order_id;
GO