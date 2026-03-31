-- =====================================
-- CUSTOMER CHURN ANALYSIS
-- PostgreSQL SQL Script
-- =====================================

-- STEP 1: CREATE TABLE
CREATE TABLE churn_data (
    gender TEXT,
    seniorcitizen INT,
    partner INT,
    dependents INT,
    tenure INT,
    phoneservice INT,
    multiplelines INT,
    internetservice TEXT,
    onlinesecurity INT,
    onlinebackup INT,
    deviceprotection INT,
    techsupport INT,
    streamingtv INT,
    streamingmovies INT,
    contract TEXT,
    paperlessbilling INT,
    paymentmethod TEXT,
    monthlycharges FLOAT,
    totalcharges FLOAT,
    tenurecategory TEXT,
    engagementscore INT,
    contractrisk INT,
    financialpressure FLOAT,
    churn INT
);

-- STEP 2: IMPORT CSV (Instruction for user)
-- Use DBeaver Import Tool to load Final_cleaned_Telco_Customer_Churn.csv into churn_data

-- =====================================
-- STEP 3: BASIC KPIs
-- =====================================

SELECT 
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN churn = 1 THEN 1 END) AS churned_customers,
    ROUND(
        (COUNT(CASE WHEN churn = 1 THEN 1 END)::numeric * 100.0) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM churn_data;

-- 3.2 Monthly Revenue at Risk (churned customers)
SELECT 
    ROUND(
        SUM(CASE WHEN churn = 1 THEN monthlycharges ELSE 0 END)::numeric,
        2
    ) AS revenue_at_risk
FROM churn_data;

-- =====================================
-- STEP 4: SEGMENT ANALYSIS
-- =====================================

-- 4.1 Churn by Contract Type
SELECT 
    contract,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned,
    ROUND(
        COUNT(*) FILTER (WHERE churn = 1) * 100.0 / COUNT(*), 
        2
    ) AS churn_rate_percentage
FROM churn_data
GROUP BY contract
ORDER BY churn_rate_percentage DESC;

-- 4.2 Churn by Tenure Category
SELECT 
    tenurecategory,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned,
    ROUND(
        COUNT(*) FILTER (WHERE churn = 1) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM churn_data
GROUP BY tenurecategory
ORDER BY churn_rate_percentage DESC;

-- 4.3 Churn by Engagement Score
SELECT 
    engagementscore,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) FILTER (WHERE churn = 1) * 100.0 / COUNT(*), 
        2
    ) AS churn_rate_percentage
FROM churn_data
GROUP BY engagementscore
ORDER BY churn_rate_percentage DESC;

-- 4.4 Churn by Financial Pressure Level (rounded)
SELECT 
    ROUND(financialpressure::numeric, 0) AS pressure_level,
    COUNT(*) AS total_customers,
    ROUND(
        (COUNT(CASE WHEN churn = 1 THEN 1 END)::numeric * 100.0) / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM churn_data
GROUP BY ROUND(financialpressure::numeric, 0)
ORDER BY churn_rate_percentage DESC;

-- =====================================
-- STEP 5: ADVANCED ANALYSIS (High-Risk Segments)
-- =====================================

-- Using CTEs to identify top 5 high-risk segments by churn rate
WITH segment_churn AS (
    SELECT 
        contract,
        tenurecategory,
        engagementscore,
        COUNT(*) AS total_customers,
        COUNT(*) FILTER (WHERE churn = 1) AS churned_customers,
        ROUND(
            COUNT(*) FILTER (WHERE churn = 1) * 100.0 / COUNT(*), 2
        ) AS churn_rate_percentage
    FROM churn_data
    GROUP BY contract, tenurecategory, engagementscore
)
SELECT *
FROM segment_churn
WHERE total_customers >= 10  -- filter small groups
ORDER BY churn_rate_percentage DESC
LIMIT 5;


-- Top 5 Payment Methods with highest churn rate
SELECT 
    paymentmethod,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 1) AS churned,
    ROUND(
        COUNT(*) FILTER (WHERE churn = 1) * 100.0 / COUNT(*), 2
    ) AS churn_rate_percentage
FROM churn_data
GROUP BY paymentmethod
ORDER BY churn_rate_percentage DESC
LIMIT 5;