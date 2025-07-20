# CELEBAL_SCD_ASSIGNEMENT

# 📊 Stored Procedures for Slowly Changing Dimensions (SCD Types 0–6)

This repository provides SQL Server stored procedures to implement all six types of **Slowly Changing Dimensions (SCD)** – commonly used in data warehousing to manage changes in dimensional data over time.

## 📚 Overview of SCD Types

| Type | Name                   | Description                                                                 |
|------|------------------------|-----------------------------------------------------------------------------|
| 0    | Fixed Dimension        | No changes allowed after initial insert.                                   |
| 1    | Overwrite              | Changes overwrite old values. No history maintained.                       |
| 2    | Historical Rows        | Changes are tracked using new rows with validity dates or current flags.   |
| 3    | Previous Value Column  | Only limited history is kept in separate columns.                          |
| 4    | History Table          | Changes are saved in a separate history table.                             |
| 6    | Hybrid (1+2+3)         | Combines Type 1, 2, and 3 for full flexibility and traceability.           |

---

## 🛠️ Technologies Used

- **SQL Server** (T-SQL)
- Stored Procedures
- Dimensional Modeling

---
