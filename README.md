# Customer Churn Analysis & Retention Strategy

## Table of Contents
1. [Project Overview](#project-overview)  
2. [Dataset](#dataset)  
3. [Technologies Used](#technologies-used)  
4. [Data Cleaning & Preprocessing](#data-cleaning--preprocessing)  
5. [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)  
6. [Top 5 High-Risk Customer Segments](#top-5-high-risk-customer-segments)  
7. [Visual Analysis](#visual-analysis)  
8. [SQL Analysis](#sql-analysis)  
9. [Business Recommendations](#business-recommendations)  
10. [Power BI Dashboard Blueprint](#power-bi-dashboard-blueprint)  
11. [Future Work](#future-work)  

---

## Project Overview
This project analyzes customer churn for a telecommunications company using **Python, SQL, and Power BI**. The main goal is to identify high-risk segments and provide actionable insights to reduce churn and maximize customer retention.  

**Key Objectives:**  
- Understand customer behavior and churn drivers  
- Perform data cleaning, feature engineering, and exploratory analysis  
- Identify high-risk segments  
- Visualize insights in a dashboard for business decisions  

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

## Technologies Used
- **Python:** NumPy, Pandas, Matplotlib, Seaborn  
- **SQL:** PostgreSQL (DBeaver) for aggregation and segmentation  
- **Visualization:** Power BI for interactive dashboards  
- **Data Storage & Management:** CSV files, Pandas DataFrames  

---

## Data Cleaning & Preprocessing
1. Converted `TotalCharges` to numeric and dropped 11 missing values  
2. Standardized service columns (`No phone service` / `No internet service` → `No`)  
3. Encoded binary columns to 0/1: `Churn`, `Partner`, `Dependents`, `PhoneService`, `PaperlessBilling`, and services  
4. Dropped `customerID` as it is a unique identifier with no analytical value  
5. Created engineered features:  
   - **TenureCategory:** New, Short-term, Medium-term, Long-term  
   - **EngagementScore:** Sum of subscribed services  
   - **ContractRisk:** Month-to-month = 2, One year = 1, Two year = 0  
   - **FinancialPressure:** MonthlyCharges / (Tenure + 1)  

---

## Exploratory Data Analysis (EDA)
**Overall Churn Rate:** 26.58%  

### Churn by Key Segments
| Segment                       | Churn Rate (%) |
|-------------------------------|----------------|
| Contract: Month-to-month       | 42.71          |
| TenureCategory: New            | 53.33          |
| PaymentMethod: Electronic check| 45.29          |
| InternetService: Fiber optic   | Higher churn   |

**Insights:**  
- Month-to-month contracts and new customers have the highest churn  
- Low engagement scores correlate with higher churn  
- Electronic check payers are more likely to leave  
- Long-term, high-value customers are retained better  

---

## Top 5 High-Risk Customer Segments
| Contract Type   | TenureCategory | EngagementScore | Total Customers | Churned Customers | Churn Rate (%) |
|-----------------|----------------|-----------------|----------------|-----------------|----------------|
| Month-to-month  | New            | 6               | 12             | 8               | 66.67          |
| Month-to-month  | New            | 5               | 39             | 26              | 66.67          |
| Month-to-month  | New            | 4               | 126            | 80              | 63.49          |
| Month-to-month  | New            | 3               | 215            | 135             | 62.79          |
| Month-to-month  | New            | 2               | 372            | 232             | 62.37          |

---

## Visual Analysis
- **Boxplots:** No outliers detected in `tenure`, `MonthlyCharges`, or `TotalCharges`  
- **Histograms:** Most customers are in low-to-mid MonthlyCharges; higher TotalCharges correspond to lower churn  
- **Correlation Heatmap:** Short tenure, high contract risk, and high financial pressure positively correlate with churn; long tenure and high TotalCharges negatively correlate  

---

## SQL Analysis
- Aggregations and segmentations done using SQL queries for:  
  - Churn by Contract type, TenureCategory, EngagementScore  
  - Churn by PaymentMethod  
  - Identification of high-risk segments  

---

## Business Recommendations
1. Focus retention efforts on **month-to-month and new customers**  
2. Increase engagement for low-service users through **targeted campaigns**  
3. Incentivize automated payments to reduce churn from **electronic check users**  
4. Offer flexible plans to reduce **financial pressure** impact  

---

## Power BI Dashboard Blueprint

**Page 1: Overview / KPIs**  
- **Top KPI Cards:**  
  - Total Customers: 7,032  
  - Churned Customers: 1,869  
  - Churn Rate: 26.58%  
  - Average Engagement Score: 3.2  
- **Charts:**  
  - Donut Chart: Churn distribution (Yes vs No)  
  - Histogram: Monthly Charges distribution  
- **Slicers / Filters:** None on this page, to keep the overview clear  
- **Drill-through:** Click on Churn Rate or other KPIs to see detailed churn breakdown by features such as Contract Type, Tenure Category, Payment Method, Internet Service, etc  

**Page 2: Churn by Customer Segments**  
- **Bar Charts:**  
  - Churn Rate by Contract Type (Month-to-month, One Year, Two Year)  
  - Churn Rate by Tenure Category (New, Short-term, Medium-term, Long-term)  
  - Churn Rate by Payment Method (Electronic Check, Bank Transfer, etc.)  
  - Churn Rate by Internet Service (DSL, Fiber Optic, No Service)  
- **Slicers / Filters:**  
  - Gender (Male/Female)  
  - Has Partner (Yes/No)  
  - Engagement Score Range  
  - Financial Pressure Range  
- **Drill-through:** Clicking on a Contract Type leads to the final page table, summarizing churn for each contract type, including Tenure Category, Total Customers, Churned Customers, and Churn Rate (%)  

**Page 3: High-Risk Customer Segments & Key Insights**  
- **Table / Matrix:**  
  - Columns: Contract, TenureCategory, EngagementScore, Total Customers, Churned Customers, Churn Rate (%)  
  - Conditional formatting highlights high churn rate segments  
  - Ordered by Contract Type → Tenure Category → Engagement Score for clarity  
- **Insights / Recommendations:**  
  - Month-to-month contracts have the highest churn  
  - New and short-tenure customers are more likely to churn  
  - Customers paying via electronic check are at higher risk  
  - Suggested actions:  
    - Improve onboarding for new customers  
    - Offer incentives for month-to-month contract holders  
    - Introduce alternative payment reminders or promotions  

---

## Future Work
- Apply machine learning models for **predictive churn scoring**  
- Integrate with **real-time customer data** for proactive retention  
- Test the effectiveness of **retention campaigns** using A/B analysis  
