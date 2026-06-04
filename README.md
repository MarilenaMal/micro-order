# Micro-Industrial Components Order Management System

A lightweight, high-performance local web application designed for **XAMPP environments**. This system manages micro-component inventory and production manifests, allowing for real-time scheduling adjustments, order entry, bulk ledger CSV exports, and dynamic data management.

---

## 🛠️ Technology Stack

- **Frontend:** Semantic HTML5, CSS3 (Custom Industrial Slate & Steel Palette), Native JavaScript (Vanilla ES6, Fetch API)
- **Backend:** PHP 8.x (Monolithic RESTful API approach)
- **Database:** MySQL / MariaDB (via phpMyAdmin)
- **Environment:** XAMPP (Apache Web Server)

---

## 🏗️ System Architecture: How It Works

This application operates using a decoupled architecture, even though it is hosted locally. The frontend and backend communicate asynchronously using standard web protocols.

### 1. The Frontend (Client-Side)

The user interface is built entirely with raw HTML, CSS, and JavaScript—no heavy frameworks like React or Vue are required.

- **Routing:** Navigation is handled via standard HTML links between three distinct pages (`index.html`, `manage.html`, `import.html`).
- **Data Fetching:** The UI uses the modern JavaScript `fetch()` API to send asynchronous HTTP requests (AJAX) to the backend. This means the tables and statuses update instantly without the page needing to refresh.
- **State Management:** The table rows and dropdown menus are built dynamically via JavaScript loops based on the JSON data returned from the server.

### 2. The Backend (`api.php`)

The entire server-side logic is housed within a single PHP controller file (`api.php`). It intercepts HTTP requests from the frontend and performs the appropriate CRUD (Create, Read, Update, Delete) operations.

- **GET Requests:** Fetches all current orders from the database, sorts them by creation date, and returns them to the frontend as a clean JSON array.
- **POST Requests:** Receives new order payloads from `manage.html`, sanitizes the input to prevent SQL injection, and inserts a new row into the database.
- **PUT Requests:** Listens for instant status changes from the dashboard dropdowns and updates the specific row's status in the database.
- **DELETE Requests:** Removes an order completely based on its unique ID.
- **CSV Export Logic:** If the backend detects a `?export=true` parameter in the URL, it switches its output headers from JSON to `text/csv`, forcing the browser to instantly download a compiled spreadsheet of the database.

### 3. The Database (MySQL)

A streamlined relational database (`micro_components`) containing a single table (`orders`) designed to track the order ID, part specifications, batch quantities, current production status, and timestamp.
