# Customer Churn Analysis & Retention Strategy

## Table of Contents
1. [Project Overview](#project-overview)
2. [Methodology & Quality Framework](#methodology--quality-framework)
3. [Dataset](#dataset)
4. [Data Cleaning & Preprocessing](#data-cleaning--preprocessing)
5. [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
6. [Top 5 High-Risk Customer Segments](#top-5-high-risk-customer-segments)
7. [Visual Analysis](#visual-analysis)
8. [SQL Analysis](#sql-analysis)
9. [Business Recommendations](#business-recommendations)
10. [Power BI Dashboard Blueprint](#power-bi-dashboard-blueprint)
11. [Technologies Used](#technologies-used)
12. [Future Work](#future-work)

---

## Project Overview
This project analyzes customer churn for a telecommunications company using **Python, SQL, and Power BI**. The main goal is to identify high-risk segments and provide actionable insights to reduce churn and maximize customer retention.

The entire project was structured using the **DMAIC (Define–Measure–Analyze–Improve–Control)** Six Sigma framework, treating churn as a measurable quality defect and driving data-backed decisions at every phase.

**Key Objectives:**
- Understand customer behavior and churn drivers
- Perform data cleaning, feature engineering, and exploratory analysis
- Identify high-risk segments using Pareto Analysis and data stratification
- Visualize insights in a dashboard for sustained business decision-making

---

## Methodology & Quality Framework

This project follows the **DMAIC Six Sigma methodology**, ensuring a structured, data-driven, and quality-focused approach to churn reduction.

### Define
- Identified **customer churn as the key quality defect** impacting revenue retention.
- Established measurable project goals: quantify baseline churn rate, identify high-risk segments, and deliver actionable retention recommendations.
- Scoped the dataset: **IBM Telco Customer Churn** (7,032 rows × 21 features after cleaning), with `Churn` as the binary target variable.

### Measure
- Built an end-to-end data pipeline: loading, cleaning (dropped 11 missing values, standardized service columns, encoded binary variables), and feature engineering.
- Engineered **4 impactful features** to quantify risk dimensions:

| Feature | Description |
|---------|-------------|
| `TenureCategory` | New / Short-term / Medium-term / Long-term |
| `EngagementScore` | Sum of subscribed services |
| `ContractRisk` | Month-to-month = 2, One year = 1, Two year = 0 |
| `FinancialPressure` | MonthlyCharges / (Tenure + 1) |

- Established baseline churn rate: **26.58%** (1,869 churned out of 7,032 customers).
- Used **PostgreSQL (DBeaver)** for SQL-based aggregations and segmentation across contract types, tenure categories, payment methods, and engagement scores.

### Analyze
- Applied **Pareto Analysis** to isolate the top churn drivers — month-to-month new customers with low engagement scores showed churn rates up to **66.67%**, accounting for the majority of revenue at risk.
- Used **data stratification** to break down churn rates across key dimensions:

| Segment | Churn Rate (%) |
|---------|----------------|
| Contract: Month-to-month | 42.71 |
| TenureCategory: New | 53.33 |
| PaymentMethod: Electronic check | 45.29 |
| InternetService: Fiber optic | Higher churn |

- Built a **correlation heatmap** confirming: short tenure, high contract risk, and high financial pressure positively correlate with churn; long tenure and high TotalCharges negatively correlate.
- Identified that low engagement scores are a leading indicator of churn risk across all segments.

### Improve
- Translated findings into **4 prioritized business recommendations**, ranked by churn rate impact:
  1. Focus retention efforts on month-to-month and new customers
  2. Increase engagement for low-service users through targeted campaigns
  3. Incentivize automated payments to reduce churn from electronic check users
  4. Offer flexible plans to reduce financial pressure impact
- Recommendations were scoped using a **data-driven impact/effort prioritization** approach based on segment size and churn rate severity.

### Control
- Built a **3-page interactive Power BI dashboard** to monitor churn trends continuously and sustain improvements:
  - **Page 1:** KPI overview (Total Customers: 7,032 · Churned: 1,869 · Churn Rate: 26.58% · Avg. Engagement Score: 3.2) with drill-through capability
  - **Page 2:** Churn breakdown by Contract Type, Tenure Category, Payment Method, and Internet Service — with slicers for Gender, Partner status, Engagement Score, and Financial Pressure
  - **Page 3:** High-risk segment matrix with **conditional formatting** highlighting critical churn rates, ordered by Contract → Tenure → Engagement Score
- Dashboard enables ongoing data-driven retention decisions without requiring re-analysis.

---

## Dataset

- **Source:** Telco Customer Churn Dataset (IBM)
- **Shape:** 7,032 rows × 21 features after cleaning
- **Target:** `Churn` (0 = No, 1 = Yes)

**Key Features:**
- Customer demographics: `gender`, `SeniorCitizen`, `Partner`, `Dependents`
- Services: `PhoneService`, `MultipleLines`, `InternetService`, `OnlineSecurity`, `OnlineBackup`, `DeviceProtection`, `TechSupport`, `StreamingTV`, `StreamingMovies`
- Contracts & billing: `Contract`, `PaperlessBilling`, `PaymentMethod`
- Financials: `MonthlyCharges`, `TotalCharges`
- Engineered features: `TenureCategory`, `EngagementScore`, `ContractRisk`, `FinancialPressure`

---

## Data Cleaning & Preprocessing

1. Converted `TotalCharges` to numeric and dropped 11 missing values
2. Standardized service columns (`No phone service` / `No internet service` → `No`)
3. Encoded binary columns to 0/1: `Churn`, `Partner`, `Dependents`, `PhoneService`, `PaperlessBilling`, and services
4. Dropped `customerID` as it is a unique identifier with no analytical value
5. Created 4 engineered features to quantify risk dimensions (see Measure phase above)

---

## Exploratory Data Analysis (EDA)

**Overall Churn Rate: 26.58%**

### Churn by Key Segments

| Segment | Churn Rate (%) |
|---------|----------------|
| Contract: Month-to-month | 42.71 |
| TenureCategory: New | 53.33 |
| PaymentMethod: Electronic check | 45.29 |
| InternetService: Fiber optic | Higher churn |

**Key Insights (Pareto Analysis):**
- Month-to-month contracts and new customers drive the majority of churn
- Low engagement scores are a leading indicator of churn risk
- Electronic check payers are significantly more likely to leave
- Long-term, high-value customers show strong retention

---

## Top 5 High-Risk Customer Segments

Identified via **Pareto-style segmentation** — month-to-month new customers with low engagement scores concentrate the highest churn rates:

| Contract Type | TenureCategory | EngagementScore | Total Customers | Churned | Churn Rate (%) |
|---------------|----------------|-----------------|-----------------|---------|----------------|
| Month-to-month | New | 6 | 12 | 8 | 66.67 |
| Month-to-month | New | 5 | 39 | 26 | 66.67 |
| Month-to-month | New | 4 | 126 | 80 | 63.49 |
| Month-to-month | New | 3 | 215 | 135 | 62.79 |
| Month-to-month | New | 2 | 372 | 232 | 62.37 |

---

## Visual Analysis

- **Boxplots:** No outliers detected in `tenure`, `MonthlyCharges`, or `TotalCharges`
- **Histograms:** Most customers are in low-to-mid MonthlyCharges; higher TotalCharges correspond to lower churn
- **Correlation Heatmap:** Confirms short tenure, high contract risk, and high financial pressure as primary churn drivers (Analyze phase)

---

## SQL Analysis

SQL aggregations and segmentations performed in **PostgreSQL (DBeaver)**:
- Churn by Contract Type, TenureCategory, and EngagementScore
- Churn by PaymentMethod
- Identification and ranking of high-risk segments (Pareto basis for recommendations)

---

## Business Recommendations

Prioritized by churn rate impact (Improve phase):

| Priority | Recommendation | Target Segment |
|----------|---------------|----------------|
| 1 | Improve onboarding and early engagement programs | New + month-to-month customers |
| 2 | Launch targeted retention campaigns for low-engagement users | EngagementScore ≤ 3 |
| 3 | Incentivize automated payment methods | Electronic check payers |
| 4 | Offer flexible or transitional plans | High FinancialPressure customers |

---

## Power BI Dashboard Blueprint

### Page 1: Overview / KPIs *(Control — Baseline Monitoring)*
- **KPI Cards:** Total Customers (7,032) · Churned (1,869) · Churn Rate (26.58%) · Avg. Engagement Score (3.2)
- **Charts:** Donut chart (Churn Yes/No) · Histogram (Monthly Charges distribution)
- **Drill-through:** Click KPIs to see detailed breakdown by Contract Type, Tenure, Payment Method, Internet Service

### Page 2: Churn by Customer Segments *(Control — Segment Monitoring)*
- **Bar Charts:** Churn Rate by Contract Type · Tenure Category · Payment Method · Internet Service
- **Slicers:** Gender · Partner status · Engagement Score range · Financial Pressure range
- **Drill-through:** Contract Type → detailed Tenure/Churn summary table

### Page 3: High-Risk Segments & Insights *(Control — Pareto Monitoring)*
- **Matrix Table:** Contract · TenureCategory · EngagementScore · Total Customers · Churned · Churn Rate (%)
- **Conditional formatting** highlights critical churn rate segments
- **Ordered:** Contract Type → Tenure Category → Engagement Score
- **Embedded recommendations** for sustained action

---

## Technologies Used

| Category | Tools |
|----------|-------|
| Programming | Python (NumPy, Pandas, Matplotlib, Seaborn) |
| Database | SQL — PostgreSQL (DBeaver) |
| Visualization | Power BI |
| Development | Jupyter Notebook |
| Data Storage | CSV files, Pandas DataFrames |
| Quality Framework | DMAIC (Six Sigma), Pareto Analysis, Data Stratification |

---

## Future Work

Scoped as next-cycle improvements following the DMAIC Control phase:

- Apply **machine learning models** for predictive churn scoring (extend the Improve phase)
- Integrate with **real-time customer data** for proactive, automated retention triggers
- Test the effectiveness of retention campaigns using **A/B analysis** (validate recommendations)
