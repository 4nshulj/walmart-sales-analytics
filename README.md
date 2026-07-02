# 🛒 Walmart Sales Analysis — End-to-End Data Analyst Project

## 🎯 Project Objective
To analyze Walmart sales performance and identify revenue drivers, customer behavior patterns, and operational opportunities using a full analytics pipeline.


**Python (Data Cleaning) → PostgreSQL (Data Storage & SQL Analysis) → Power BI (Dashboard & Insights)**

![Python](https://img.shields.io/badge/Python-Pandas-blue)
![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791)
![Power BI](https://img.shields.io/badge/Dashboard-Power%20BI-F2C811)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

---

## 📌 Project Overview

This project walks through a complete data analytics pipeline built on Walmart sales data — from raw, messy data all the way to a decision-ready dashboard.

The goal was to simulate a real-world analyst workflow: take an unclean dataset, prepare it properly, store it in a relational database, analyze it with SQL, and present the findings visually in a way that a business stakeholder could actually act on.

**Workflow:**

1. **Python (Pandas)** — Cleaned and prepared the raw Walmart transactions dataset.
2. **PostgreSQL** — Loaded the cleaned data into a relational database and ran SQL queries to answer specific business questions.
3. **Power BI** — Connected to PostgreSQL and built an interactive dashboard to visualize KPIs, trends, and category/region performance.

This project reflects the kind of end-to-end thinking expected from a data analyst: not just running queries, but connecting cleaning → storage → analysis → storytelling into one coherent narrative.

---

## 🧰 Tools & Tech Stack

| Stage | Tool | Purpose |
|---|---|---|
| Data Cleaning | **Python (Pandas)** | Handle missing values, remove duplicates, fix formatting |
| Data Storage | **PostgreSQL** | Store cleaned data in structured tables for querying |
| Analysis | **SQL** | Aggregate, filter, and analyze sales, category, and revenue trends |
| Visualization | **Power BI** | Build an interactive dashboard with KPIs and insights |

---

## 🧹 Data Cleaning (Python)

Before any analysis could happen, the raw dataset needed to be cleaned using **Pandas**. Key steps included:

- **Missing values** — Identified and handled nulls (dropped or imputed depending on the column and its importance to analysis).
- **Duplicate records** — Detected and removed duplicate transaction rows to avoid inflated totals.
- **Column formatting** — Standardized data types (dates converted to `datetime`, currency fields cleaned of symbols and cast to numeric, text fields trimmed and case-normalized).

> 📄 See  [`data_cleaning.ipynb`](./data_cleaning.ipynb) for the full cleaning script.



---

## 🗄️ Database Step (PostgreSQL)

Once cleaned, the data was loaded into **PostgreSQL** using Python (`sqlalchemy` / `psycopg2`), where it was structured into relational tables suitable for querying.

SQL was then used to answer specific business questions, including:

- Which payment method is used most frequently, and for the highest volume of transactions?
- Which product category generates the most revenue?
- Which branch generated the most revenue in 2023?

### Key SQL-driven findings:

- 💳 **Credit card** is the most-used payment method — both in number of transactions and quantity of items purchased.
- 👗 **Fashion accessories** is the top revenue-generating category, ahead of electronics, food & beverage, and all other categories.
- 🏬 **Branch WALM009** generated the highest revenue in 2023 across all branches.

> 📄 See [`schema_analysis.sql`](./schema_analysis.sql) for the full set of queries used.

---

## 📊 Dashboard (Power BI)

The cleaned and queried data was connected to **Power BI** to build an interactive dashboard covering:

- **Sales KPIs** — Total revenue, year-on-year growth, transaction volume
- **Category analysis** — Revenue breakdown by product category
- **Region analysis** — City/branch-level performance comparison
- **Trends** — Revenue growth patterns across the FY 2022–2023 period

### 🔑 Key Insights

| Insight | Detail |
|---|---|
| 📈 **YoY Revenue Growth** | **+23.76%** revenue growth from 2022 to 2023 — the strongest signal in the dataset |
| 🌆 **Top City by Revenue** | **Weslaco** generates the highest city-level revenue |
| 🛍️ **Top Category** | **Fashion accessories** leads all categories in revenue |
| 💳 **Preferred Payment Method** | **Credit card** is the most frequently used payment method |
| ⏰ **Peak Transaction Window** | **B Shift (12 PM – 5 PM)** drives the highest number of transactions |

### 💡 Business Recommendations

1. **Double down on fashion** — Expand fashion accessories SKUs and run seasonal promotions to sustain category leadership.
2. **Optimize afternoon operations** — Schedule peak staffing during the 12 PM–5 PM window and push flash deals to maximize conversion.
3. **Replicate the Weslaco model** — Audit Weslaco's product mix and store operations, and apply those learnings to lower-performing cities.
4. **Leverage the digitally-comfortable customer base** — Credit card dominance suggests an opportunity for co-branded card offers or loyalty programs tied to card spend.

>## 📊 Dashboard Preview
> ![Dashboard Preview](https://github.com/4nshulj/walmart-sales-analytics/blob/main/images/dashboard_preview.png)
> ```

---

## 📁 Project Structure

```
walmart-sales-analysis/
│
├── data/
│   ├── raw.csv              # Original unclean dataset
│   └── cleaned.csv          # Cleaned dataset (post-Python processing)
│
├── notebooks/
│   └── data_cleaning.ipynb       # Python cleaning steps
│
├── sql/
│   └── schema_analysis.sql      # SQL queries used for analysis
│
├── dashboard/
│   └── walmart_dashboard.pbix    # Power BI dashboard file
│
├── images/
│   └── dashboard_preview.png     # Dashboard screenshot for README
│
|
└── README.md                     # Project documentation (this file)
```

---

## ⚙️ How to Run This Project Locally

1. **Clone the repository**
   ```bash
   git clone https://github.com/<your-username>/walmart-sales-analysis.git
   cd walmart-sales-analysis
   ```

2. **Set up a Python environment and install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Run the cleaning script/notebook**
   ```bash
   jupyter notebook notebooks/data_cleaning.ipynb
   ```

4. **Load cleaned data into PostgreSQL**
   - Create a database (e.g., `walmart_sales`)
   - Update your database credentials in the connection script
   - Run the load script to insert `cleaned_data.csv` into PostgreSQL

5. **Run SQL analysis**
   - Execute queries in `sql/analysis_queries.sql` using pgAdmin, DBeaver, or `psql`

6. **Open the dashboard**
   - Open `dashboard/walmart_dashboard.pbix` in Power BI Desktop
   - Update the PostgreSQL connection settings if needed, then refresh

---

## 🚀 Key Takeaways 

- Ability to take **raw, messy data** and prepare it for analysis using Python
- Comfort working with **relational databases** and writing analytical SQL queries
- Ability to translate SQL findings into a **business-focused BI dashboard**
- Skill in turning numbers into **clear, actionable business recommendations** — not just charts

---



## 👤 Author
**Anshul**
Aspiring Data Analyst | Python · SQL · Power BI
📧 [1311anshul@gmail.com] | 🔗 [LinkedIn](https://www.linkedin.com/in/anshuljangra4/) 
