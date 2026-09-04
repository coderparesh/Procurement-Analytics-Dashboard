# 📊 Procurement Analytics Dashboard

**Data Analyst Portfolio Project | Power BI Dashboard | Power Query ETL | KPI Reporting**

An end-to-end Business Intelligence project analyzing procurement operations and supplier performance using real-world data — 777 purchase orders spanning 2022–2024 across 5 suppliers and multiple product categories.

---

## 🎯 Business Problem

Procurement managers need visibility into:
- Which suppliers are delivering on time and maintaining quality
- Where procurement spend is being optimized vs. overspent
- Which vendors pose operational or compliance risk
- Opportunities for cost negotiation and savings

This project addresses these challenges through data-driven analysis and interactive reporting.

---

## 📂 Dataset Overview

- **Source:** Kaggle — Procurement KPI Analysis Dataset
- **Records:** 777 purchase orders
- **Time Period:** January 2022 — January 2024
- **Suppliers:** 5 (Alpha_Inc, Beta_Supplies, Gamma_Co, Delta_Logistics, Epsilon_Group)
- **Product Categories:** Electronics, MRO, Office Supplies, Packaging, Raw Materials
- **Key Metrics:** Order value, delivery time, defect rate, compliance status, negotiated vs. actual pricing

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| Microsoft Excel | Data cleaning, preparation, and quality checks |
| Power Query | Data transformation and ETL processing |
| Power BI Desktop | Data modeling, DAX calculations, and visualization |
| DAX | Custom measures and KPI calculations |

---

## SQL Case Study

This project includes a SQL case study with 30 business-focused queries covering procurement spend, supplier performance, delivery delays, defect rates, compliance tracking, savings opportunity, and high-risk supplier identification.

SQL skills used:
- SELECT, WHERE, ORDER BY
- GROUP BY and aggregate functions
- CASE WHEN logic
- CTEs
- Subqueries
- Window functions
- KPI calculations
- Business insight generation

File:
`sql_queries/procurement_sql_case_study.sql`

---
## 📊 Data Cleaning & Transformation Process

**Steps performed:**
1. **Data Validation** — Identified and resolved inconsistencies, null values, and outliers
2. **Data Standardization** — Normalized supplier names, categories, and date formats
3. **Feature Engineering** — Created derived fields (delivery status, cost variance, compliance flags)
4. **Power Query ETL** — Automated data refresh and transformation pipeline
5. **Data Modeling** — Built star schema relationships for efficient analysis

**Result:** Clean, validated dataset ready for BI analysis

---

## 🎨 Dashboard Features

**PAGE 1 — Procurement Overview**
- Total spend, order count, and key performance metrics
- On-time delivery rate, defect rate, and compliance overview
- Monthly procurement trends and forecasting

**PAGE 2 — Supplier Performance Analysis**
- Supplier-wise delivery performance and quality metrics
- Supplier performance scoring and ranking
- Risk assessment and compliance tracking

**PAGE 3 — Cost & Savings Analysis**
- Cost variance between negotiated and actual prices
- Savings opportunities by supplier and category
- Category-level spend analysis and optimization recommendations

---

## 📈 Key KPIs & Calculations

| KPI | Definition |
|-----|-----------|
| **Total Spend** | Sum of (Quantity × Unit Price) across all orders |
| **Total Orders** | Count of all purchase orders |
| **On-Time Delivery %** | (Orders delivered on time / Total orders) × 100 |
| **Avg Lead Time** | Average number of days from order to delivery |
| **Defect Rate %** | (Defective units / Total units ordered) × 100 |
| **Supplier Performance Score** | Composite rating (0–5) based on delivery, quality, compliance |
| **Total Negotiated Savings** | Sum of (Negotiated price - Actual price) × Quantity |
| **Cost Savings Opportunity %** | (Potential savings / Total spend) × 100 |
| **Compliance Rate %** | (Compliant orders / Total orders) × 100 |
| **Pending Orders** | Count of orders still in transit |
| **Cancelled Orders** | Count of cancelled purchase orders |

---

## 🔍 Key Insights

- **High-Risk Supplier Identified:** Delta_Logistics shows concerning metrics
  - 70.2% on-time delivery (lowest among peers)
  - 10.83% defect rate (highest)
  - 60.82% compliance rate (lowest)

- **Cost Optimization Opportunity:** $4M in potential savings identified
  - All product categories showing price variance vs. negotiated contracts
  - Represents ~8% of total procurement spend

- **Delivery Performance:** 72.1% overall on-time delivery rate
  - 1 in 4 orders experience delays
  - Opportunity for supplier performance improvement agreements

- **Top Performing Suppliers:** Alpha_Inc and Epsilon_Group
  - Consistently rated 4.3/5 on performance metrics
  - Recommended for contract expansion and priority partnership

---

## 💡 Business Recommendations

1. **Supplier Optimization** — Consider consolidating volume with top-performing suppliers (Alpha_Inc, Epsilon_Group)
2. **Risk Mitigation** — Establish performance improvement plan for Delta_Logistics or consider alternative sourcing
3. **Cost Negotiation** — Leverage savings opportunity data in supplier contract renewal discussions
4. **Process Improvement** — Implement KPI-based scorecard system for ongoing supplier monitoring
5. **Data Governance** — Continue regular data validation and KPI tracking for continuous improvement

---

## 🎓 Skills Demonstrated

- **Business Intelligence:** Dashboard design, KPI definition, and business insight generation
- **Data Analysis:** Data cleaning, KPI analysis, supplier performance tracking, and business insight generation
- **Data Transformation:** ETL pipeline development using Power Query
- **DAX Expertise:** Complex measure creation for multi-dimensional analysis
- **Reporting:** KPI reporting, performance tracking, and executive communication
- **Stakeholder Impact:** Actionable insights supporting procurement strategy and vendor management

---

## 📁 Repository Structure

```
Procurement-Analytics-Dashboard/
├── Procurement_Analytics_Dashboard.pbix    # Power BI project file
├── Purchase_Orders.xlsx                    # Cleaned and processed dataset
├── PAGE 1                                  # Dashboard screenshot (Procurement Overview)
├── PAGE 2                                  # Dashboard screenshot (Supplier Performance)
├── PAGE 3                                  # Dashboard screenshot (Cost & Savings)
├──procurement_sql_case_study               # SQL queries             
└── README.md                               # Project documentation.


---

## 👀 How Recruiters Can Review This Project

1. **Understand the Business Context** — Read the Business Problem and Insights sections
2. **Review Dashboard Design** — Open PAGE 1, 2, and 3 screenshots to see visualization approach
3. **Examine Data Model** — In the PBIX file, review how dimensions and fact tables are structured
4. **Check DAX Calculations** — Open the Measures section to see KPI logic
5. **Evaluate Data Quality** — Review the Purchase_Orders.xlsx to understand data validation approach

**Time to review:** ~10 minutes for screenshots, ~20 minutes for full PBIX file analysis

---

## 👤 Author

**Naveen Koyyala**
- **Target Roles:** Data Analyst, BI Analyst, MIS Analyst, Reporting Analyst, Power BI Analyst
- **Location:** Hyderabad, India
- **LinkedIn:** https://www.linkedin.com/in/naveen-koyyala/
- **Email:** koyyalanaveen566@gmail.com
- **GitHub:** https://github.com/Koyyalanaveen

---

**Status:** Completed ✓ | **Last Updated:** 2026-05-25
