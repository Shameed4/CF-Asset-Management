# Asset Tracker

A lightweight, web-based inventory management application built with Adobe ColdFusion. This system allows administrators to track corporate assets, manage employee records, and handle asset assignments.

## Features

* **Dashboard:** High-level view of total assets, total value, and unassigned inventory.
* **Asset Management:** Create, read, update, and delete (CRUD) hardware assets.
* **Employee Management:** Manage employee directory and departments.
* **Assignment Tracking:** Link assets to specific employees to track custody.
* **Live Search:** AJAX-based search functionality for both assets and employees using JSON APIs.
* **Financial Tracking:** Record and calculate asset costs.

## Tech Stack

* **Backend:** ColdFusion (CFML Script Syntax)
* **Database:** SQL Server (Compatible with MySQL/Oracle with minor adjustments)
* **Frontend:** HTML5, CSS3 (Custom), Vanilla JavaScript (ES6 Fetch API)
* **Architecture:** MVC-lite (Model components separate from View templates)

## Project Structure

```text
/
├── api/              # JSON endpoints for AJAX search
├── asset/            # Asset CRUD views
├── css/              # Application styles
├── employee/         # Employee CRUD views
├── model/            # Data Access Objects (CFCs)
├── Application.cfc   # App configuration & Datasource definition
└── index.cfm         # Main Dashboard
```

## Setup & Installation

### 1. Database Setup
Execute the following SQL script to create the required tables. This schema assumes SQL Server but can be adapted for MySQL.

```sql
CREATE TABLE employees (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL
);

CREATE TABLE assets (
    id INT IDENTITY(1,1) PRIMARY KEY,
    asset_name VARCHAR(150) NOT NULL,
    serial_number VARCHAR(100) NOT NULL,
    assigned_date DATE NOT NULL,
    cost DECIMAL(10, 2) NOT NULL,
    employee_id INT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE SET NULL
);
```

### 2. ColdFusion Configuration
1.  Log in to your ColdFusion Administrator.
2.  Navigate to **Data & Services > Data Sources**.
3.  Create a new datasource named `asset_tracker_ds`.
4.  Point it to the database created in Step 1.

### 3. Application Deployment
1.  Copy the project files to your web root (e.g., `C:\inetpub\wwwroot\AssetTracker` or similar).
2.  Access the application via your browser (e.g., `http://localhost/AssetTracker/index.cfm`).

## API Usage

The application exposes two read-only endpoints used by the frontend search:

* **Get Assets:** `GET /api/assets.cfm?q={search_term}`
* **Get Employees:** `GET /api/employees.cfm?q={search_term}`

## Security Notes

* All database interactions utilize `cfqueryparam` to prevent SQL injection.
* Input validation is handled via standard HTML5 form attributes and server-side type enforcement.