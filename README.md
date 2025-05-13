# Canadian Western Bank – Data Modeling and SQL Code Challenge (2023)

This repository contains my solution to a SQL-based technical coding challenge completed during the interview process for a contract role at **Canadian Western Bank**. The challenge evaluated data modeling, SQL scripting, and business intelligence reporting based on a fictional retail scenario.

---

## 📌 Overview

The assignment required:
- Designing a **star schema** using an operational ERD
- Writing a **single SQL script** to generate:
  - Machine Learning training data
  - Year-to-date (YTD) sales performance report

---

### ✅ Challenge Objectives

1. **Design a Star Schema**
   - Defined dimension and fact tables to model sales order and product relationships.
   - Created DDL for `DimProduct`, `DimOrder`, `DimTerritory`, `DimSalesEmployee`, `FactOrderDetail`, and `FactSales`.

2. **Stored Procedures**
   - `GetDataForMlAlgorithm`: Joins multiple dimensions with fact data for ML-ready format.
   - `GetDataForManagementReport`: Dynamically filters salespeople by name and territory using dynamic SQL.

3. **Bonus Insights**
   - Calculated `PercentOfTotal` sales contribution.
   - Ranked salespeople using `DENSE_RANK()` based on `SalesYTD`.

---

## 📁 Repository Structure

```text
canadian-western-bank-code-challenge/
│
├── return/                             # Final deliverables
│   ├── report.sql                      # Full SQL script for challenge solution
│   └── star-schema-cwb-code-challenge.pdf  # Star schema diagram (Lucidchart)
│
├── docs/                               # Supporting documentation
│   ├── coding-assignment-revised.pdf       # Case study instructions
│   └── megacorp-operational-data-model.pdf # Operational ERD (provided)
│
└── README.md                           # Project description and context
```
## 🧠 Technical Highlights

- 📐 **Star Schema Design**: Modeled for both analytical and machine learning consumption.
- 🧾 **SQL Logic**: Delivered two business reports in one file using dynamic SQL, window functions, and modular SQL.
- ⚙️ **Optimized Workflow**: Avoided cursors; implemented ranking logic and dynamic percent-of-total metrics.
- 🔐 **Data Compliance**: Followed realistic production-grade practices such as RBAC and scalability considerations.

---

## 💡 Tools & Technologies

- SQL (ANSI standard, SQL Server-compatible)
- Lucidchart (for data modeling)
- Microsoft Word & PDF (for documentation)

---

## 🔍 Disclaimer

This solution was developed for interview evaluation purposes only. All data and business scenarios are fictional and non-confidential. This repository is not affiliated with Canadian Western Bank or any of its official entities.

---

## 🔗 Connect with Me

- 📄 [LinkedIn – chandandeep22](https://www.linkedin.com/in/chandandeep22)
- 💻 [GitHub – chamehta](https://github.com/chamehta)
