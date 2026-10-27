# 📊 SQL Data Analytics: Enterprise E-Commerce Business Intelligence

<p align="center">
  <img src="https://img.shields.io/badge/Database-Google%20BigQuery-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white" alt="Google BigQuery" />
  <img src="https://img.shields.io/badge/Language-ANSI%20SQL-F80000?style=for-the-badge&logo=mysql&logoColor=white" alt="SQL" />
  <img src="https://img.shields.io/badge/Domain-E--Commerce%20Analytics-00C853?style=for-the-badge" alt="Domain" />
  <img src="https://img.shields.io/badge/Dataset-Google%20Analytics%20Sample-FF6F00?style=for-the-badge" alt="Dataset" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License" />
</p>

A structured repository of **production-grade SQL analytical queries and business intelligence case studies** developed by **Kunal Nevage**. Centered on large-scale e-commerce transactional data in **Google BigQuery** (`data-to-insights.ecommerce.all_sessions`), this project extracts critical operational KPIs—including geographic revenue concentration, SKU velocity, and marketing channel attribution.

---

## 🎯 Business Problem & Analytics Objective

Modern digital commerce platforms generate millions of user clickstream and transaction events. Without targeted SQL aggregation and funnel modeling, executives cannot determine which channels drive high-LTV purchases or which geographies yield the highest average order value (AOV).

This analytical suite delivers:
- **Geographic Revenue Attribution**: Identifying top-performing metro areas while sanitizing unmapped data points.
- **Product Velocity Rankings**: Pinpointing best-selling product lines by physical unit volume to drive inventory replenishment.
- **Multi-Channel Acquisition Evaluation**: Comparing customer acquisition across Organic Search, Direct, Paid Search, and Social channels.
- **Financial Normalization**: Converting raw micro-currency units ($\text{USD} \times 10^6$) into standardized dollar amounts.

---

## 🔬 Analytical Query Modules (`Ecommerce_Sales_Analysis`)

### 1. 🌆 Top Revenue Generating Cities
Calculates aggregate transaction revenue per municipality, excluding noise and demo placeholders:
```sql
SELECT 
  city, 
  ROUND(SUM(totalTransactionRevenue) / 1000000, 2) AS total_revenue_usd
FROM `data-to-insights.ecommerce.all_sessions`
WHERE totalTransactionRevenue IS NOT NULL 
  AND city != '(not set)'
  AND city != 'not available in demo dataset'
GROUP BY city
ORDER BY total_revenue_usd DESC
LIMIT 10;
```
*Business Value: Optimizes targeted regional ad campaigns and localized fulfillment centers.*

---

### 2. 📦 Top SKUs by Unit Velocity
Aggregates product order volumes across the global customer catalog:
```sql
SELECT
  v2ProductName AS product_name,
  SUM(productQuantity) AS total_units_sold
FROM `data-to-insights.ecommerce.all_sessions`
WHERE productQuantity IS NOT NULL
GROUP BY v2ProductName
ORDER BY total_units_sold DESC
LIMIT 10;
```
*Business Value: Informs warehouse safety-stock thresholds and vendor purchase orders.*

---

### 3. 📣 Acquisition Channel Conversion & Attribution
Evaluates marketing source channels to identify conversion efficiencies:
```sql
SELECT 
  channelGrouping,
  COUNT(DISTINCT fullVisitorId) AS unique_visitors,
  COUNT(DISTINCT transactionId) AS total_transactions,
  ROUND(SUM(totalTransactionRevenue) / 1000000, 2) AS channel_revenue_usd,
  ROUND((COUNT(DISTINCT transactionId) * 100.0) / NULLIF(COUNT(DISTINCT fullVisitorId), 0), 2) AS conversion_rate_pct
FROM `data-to-insights.ecommerce.all_sessions`
GROUP BY channelGrouping
ORDER BY channel_revenue_usd DESC;
```
*Business Value: Informs ROAS (Return on Ad Spend) and marketing budget allocation.*

---

## 🛠️ Tech Stack & Tools

| Component | Platform / Standard | Role |
|---|---|---|
| **SQL Engine** | Google Cloud BigQuery | Cloud data warehousing & petabyte-scale execution |
| **SQL Dialect** | ANSI SQL / Google Standard SQL | Window functions, aggregations, filtering, and data cleaning |
| **Benchmark Dataset** | `data-to-insights.ecommerce.all_sessions` | Real-world enterprise Google Merchandise Store clickstream events |

---

## 📁 Repository Structure

```plaintext
SQL-Data-Analytics/
├── Ecommerce_Sales_Analysis/
│   ├── ecommerce_queries.sql    # Clean, documented SQL scripts
│   └── README.md                # Module-specific query walkthrough
└── README.md                    # Master documentation and analytical findings
```

---

## ⚙️ How to Run Queries on Google BigQuery

1. Open the [Google Cloud BigQuery Console](https://console.cloud.google.com/bigquery).
2. Ensure you have access to a Google Cloud project with BigQuery enabled (the free **BigQuery Sandbox** requires no credit card).
3. Copy any query block from [`ecommerce_queries.sql`](file:///c:/Users/Asus/Documents/antigravity/friendly-babbage/SQL-Data-Analytics/Ecommerce_Sales_Analysis/ecommerce_queries.sql).
4. Paste the SQL query into the Query Editor and click **Run**.
5. Export results to Google Sheets, CSV, or Looker Studio for immediate dashboard visualization.

---

## 🛡️ License

This project is open-source and available under the [MIT License](LICENSE).
