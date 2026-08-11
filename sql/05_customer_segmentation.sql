USE ecommerce;
GO

-- Score customers and assign text segments
WITH ScoredRFM AS (
    SELECT 
        customer_unique_id, 
        recency, 
        frequency, 
        monetary,
        CASE 
            WHEN recency <= 90 THEN 5 
            WHEN recency <= 180 THEN 4
            WHEN recency <= 270 THEN 3
            WHEN recency <= 365 THEN 2 
            ELSE 1 
        END AS recency_score,
        CASE 
            WHEN frequency >= 5 THEN 5 
            WHEN frequency = 4 THEN 4
            WHEN frequency = 3 THEN 3
            WHEN frequency = 2 THEN 2 
            ELSE 1 
        END AS frequency_score,
        CASE 
            WHEN monetary >= 1000 THEN 5 
            WHEN monetary >= 500 THEN 4
            WHEN monetary >= 250 THEN 3
            WHEN monetary >= 100 THEN 2 
            ELSE 1 
        END AS monetary_score
    FROM dbo.Customer_RFM
)
SELECT 
    *,
    CASE
        WHEN recency_score >= 4 AND frequency_score >= 4 AND monetary_score >= 4 THEN 'Champions'
        WHEN recency_score >= 3 AND frequency_score >= 3 AND monetary_score >= 3 THEN 'Loyal Customers'
        WHEN recency_score >= 4 AND frequency_score <= 2 THEN 'Potential Loyalists'
        WHEN recency_score <= 2 AND monetary_score >= 4 THEN 'At Risk - High Value'
        WHEN recency_score <= 2 AND frequency_score >= 3 THEN 'At Risk'
        WHEN recency_score <= 2 THEN 'Hibernating'
        ELSE 'Need Attention'
    END AS customer_segment
INTO dbo.Customer_Segments
FROM ScoredRFM;
GO