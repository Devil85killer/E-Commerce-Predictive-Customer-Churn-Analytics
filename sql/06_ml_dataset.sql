USE ecommerce;
GO

WITH MaxDate AS(
    SELECT MAX(order_purchase_timestamp) AS max_date
    FROM dbo.Customer_Transactions
),
Cutoff AS(
    SELECT DATEADD(DAY, -180, max_date) AS cutoff_date
    FROM MaxDate
),
CustomerFeatures AS(
    SELECT
        t.customer_unique_id,
        DATEDIFF(DAY, MAX(t.order_purchase_timestamp), c.cutoff_date) AS recency,
        COUNT(DISTINCT t.order_id) AS frequency,
        SUM(t.total_order_value) AS monetary,
        AVG(t.total_order_value) AS avg_order_value,
        MIN(t.order_purchase_timestamp) AS first_purchase_date,
        MAX(t.order_purchase_timestamp) AS last_purchase_date
    FROM dbo.Customer_Transactions AS t
    CROSS JOIN Cutoff AS c
    WHERE t.order_purchase_timestamp <= c.cutoff_date
    GROUP BY t.customer_unique_id, c.cutoff_date
),
CustomerFuture AS(
    SELECT DISTINCT t.customer_unique_id
    FROM dbo.Customer_Transactions AS t
    CROSS JOIN Cutoff AS c
    WHERE t.order_purchase_timestamp > c.cutoff_date
      AND t.order_purchase_timestamp <= DATEADD(DAY, 180, c.cutoff_date)
)
SELECT
    f.customer_unique_id,
    f.recency,
    f.frequency,
    f.monetary,
    f.avg_order_value,
    DATEDIFF(DAY, f.first_purchase_date, f.last_purchase_date) AS customer_lifetime_days,
    
    -- The Integer Fix for Machine Learning Targets
    CAST(
        CASE
            WHEN cf.customer_unique_id IS NULL THEN 1
            ELSE 0
        END AS INT
    ) AS churn_target

INTO dbo.Customer_Churn_ML
FROM CustomerFeatures AS f
LEFT JOIN CustomerFuture AS cf
    ON f.customer_unique_id = cf.customer_unique_id;
GO