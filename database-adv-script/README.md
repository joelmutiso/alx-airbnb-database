# 🚀 Advanced SQL Mastery: ALX Airbnb Database 🚀

Welcome! This repository contains a series of advanced SQL scripts and reports focused on **optimizing**, **analyzing**, and **managing** the ALX Airbnb database. Each task tackles a core concept required for high-performance database engineering.

---

## 🔑 Key Concepts Covered

* 🧩 **Complex Queries:** Writing `INNER`, `LEFT`, and `FULL OUTER` joins.
* 🔍 **Subqueries:** Using correlated and non-correlated queries to solve multi-step problems.
* 📊 **Aggregations & Window Functions:** Mastering `GROUP BY` and `RANK()` for analysis.
* 📚 **Indexing:** Using `CREATE INDEX` to speed up queries and `EXPLAIN` to prove it.
* 🚀 **Optimization:** Refactoring "bad" queries (like `SELECT *`) into "good," high-performance queries.
* 🗂️ **Partitioning:** Splitting massive tables by date to make queries exponentially faster.
* 👀 **Monitoring:** Using `EXPLAIN ANALYZE` to create a feedback loop for continuous improvement.

---

## 📂 Project Structure & Tasks

This project is broken down into 7 key tasks, each building on the last.

### 0. 🧩 Complex Queries with Joins
* **Objective:** Master `INNER`, `LEFT`, and `FULL OUTER` joins to skillfully combine data from multiple tables, handling both matching and non-matching records.
* **File:**
    * `database-adv-script/joins_queries.sql`: Contains the SQL queries for all three join types.

### 1. 🔍 Practice Subqueries
* **Objective:** Write correlated (dependent) and non-correlated (independent) subqueries to solve complex problems that require asking a "question inside a question."
* **File:**
    * `database-adv-script/subqueries.sql`: Shows examples of both subquery types to find specific users and properties.

### 2. 📊 Aggregations and Window Functions
* **Objective:** Use `GROUP BY` and `COUNT()` to aggregate data, and use window functions like `RANK()` to analyze data *without* collapsing rows.
* **File:**
    * `database-adv-script/aggregations_and_window_functions.sql`: Contains queries to count user bookings and rank properties by popularity.

### 3. 📚 Implement Indexes for Optimization
* **Objective:** Identify high-usage "bridge" columns (foreign keys) and "search" columns (`WHERE` clauses) and apply `CREATE INDEX` to them to accelerate queries.
* **Files:**
    * `database-adv-script/database_index.sql`: The SQL commands to create all the necessary indexes.
    * `database-adv-script/index_performance.md`: A "before-and-after" report using `EXPLAIN` to prove the indexes change the query plan from a slow `Seq Scan` to a fast `Index Scan`.

### 4. 🚀 Optimize Complex Queries
* **Objective:** Identify and refactor a slow, inefficient query (using `SELECT *` on 4 tables) into a fast, optimized query that selects only the specific columns needed.
* **Files:**
    * `database-adv-script/perfomance.sql`: Contains the "before" (bad) and "after" (good) queries side-by-side.
    * `database-adv-script/optimization_report.md`: An analysis report explaining *why* `SELECT *` is so slow and how the refactored query is superior.

### 5. 🗂️ Partitioning Large Tables
* **Objective:** Implement table partitioning on the massive `Bookings` table. This splits one giant table into smaller, manageable "child" tables based on the `start_date`.
* **Files:**
    * `database-adv-script/partitioning.sql`: The SQL commands to create the new partitioned table structure.
    * `database-adv-script/partition_performance.md`: A report showing how partitioning enables **"Partition Pruning,"** allowing the database to scan only one small table (e.g., `bookings_y2024`) instead of the entire table for date-range queries.

### 6. 👀 Monitor and Refine Database Performance
* **Objective:** Establish a workflow for continuously monitoring query performance using `EXPLAIN ANALYZE` to find new bottlenecks and refine the database schema over time.
* **File:**
    * `database-adv-script/performance_monitoring.md`: A sample report demonstrating the process: **1. Monitor** a slow query, **2. Identify** the bottleneck (a `Seq Scan`), **3. Implement** a fix (a new index), and **4. Report** the improvement (a new `Index Scan` and lower cost).