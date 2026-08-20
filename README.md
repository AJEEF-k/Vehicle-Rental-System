# DriveWay – Vehicle Rental System

DriveWay is a Java-based web application for renting and managing vehicles online. The system provides separate modules for **Customers, Vendors, and System Administrators**, with role-based authentication, authorization, vehicle management, booking management, and review functionality.

---
  
## 🎥 Demo Video

<!-- Drag and drop your project demo video here while editing this README on GitHub. -->

<!-- GitHub will automatically insert the uploaded video reference below this line. -->

---

### Home Page
![DriveWay Home Page](docs/screenshots/herosection.png)
### Customer Registration
![Customer Registration](docs/screenshots/customerRegistration.png)
### Login
![Login Page](docs/screenshots/loginPage.png)
### Customer Dashboard
![Customer Dashboard](docs/screenshots/customerDashboard.png)
### Browse Vehicles
![Browse Vehicles](docs/screenshots/browseVehicle.png)
### Vendor Registration
![Vendor Registration](docs/screenshots/vendorRegistration.png)
### Vendor Dashboard
![Vendor Dashboard](docs/screenshots/vendorDashboard.png)
### Vendor Vehicle Management
![Vendor Vehicle Management](docs/screenshots/vendorMyVehicle.png)
### Admin Dashboard
![Admin Dashboard](docs/screenshots/adminDashboard.png)
### Manage Users
![Manage Users](docs/screenshots/manageUsers.png)
### Manage Vendors
![Manage Vendors](docs/screenshots/manageVendors.png)

---

## 📋 Project Overview

DriveWay allows customers to:

* Browse available vehicles
* Search for vehicles
* View detailed vehicle information
* Make rental bookings
* Manage existing bookings
* Cancel eligible bookings
* Submit vehicle and vendor reviews
* Manage their profile and password

Vendors can:

* Register their rental business
* Manage their vendor profile
* Add and manage vehicles
* Manage vehicle availability and operational status
* View and manage customer bookings

System administrators can:

* Manage customer accounts
* Approve or reject vendor registrations
* View registered vehicles
* View bookings
* Monitor customer reviews

The application follows the **MVC architecture** and **DAO design pattern** to separate presentation, controller, business, and database operations.

---

## ✨ Key Features

### 👤 Customer Module

* Customer registration and login
* Browse available vehicles
* Search vehicles
* View vehicle details
* Vehicle image display
* Book vehicles
* Select hourly or daily rental rates
* Select payment method
* View booking history
* Cancel eligible bookings
* Submit vehicle and vendor ratings
* Update profile
* Change password
* Account activation and deactivation support

### 🏢 Vendor Module

* Dedicated vendor registration
* Vendor approval workflow
* Vendor login with authorization
* Vendor dashboard
* Add vehicles
* Edit vehicle details
* View vehicle images
* Manage vehicle operational status
* View customer bookings
* Start confirmed bookings
* Cancel confirmed bookings
* Complete active bookings
* Update vendor profile
* Change password

### 🛡️ Admin Module

* Admin login
* Admin dashboard
* View all users
* Activate or deactivate customer accounts
* View registered vendors
* Approve or reject vendor registrations
* View all vehicles
* View all bookings
* View customer reviews

---

## 🔐 Role-Based Access Control

```text
CUSTOMER
   |
   +-- Browse Vehicles
   +-- View Vehicle Details
   +-- Book Vehicles
   +-- Manage Bookings
   +-- Submit Reviews
   +-- Manage Profile
   +-- Change Password


VENDOR
   |
   +-- Register
   +-- Requires Admin Approval
   +-- Manage Vehicles
   +-- Manage Bookings
   +-- Manage Vendor Profile
   +-- Change Password


ADMIN
   |
   +-- Manage Customers
   +-- Manage Vendors
   +-- Approve / Reject Vendors
   +-- View Vehicles
   +-- View Bookings
   +-- View Reviews
```

---

## 🔄 Vendor Approval Workflow

New vendors cannot access vendor features until an administrator approves their vendor account.

```text
Vendor Registration
        |
        v
User Account Created
        |
        v
Vendor Profile Created
        |
        v
Approval Status = PENDING
        |
        v
Admin Reviews Vendor
        |
     +--+--+
     |     |
 Approve Reject
     |
     v
 APPROVED
     |
     v
Vendor Login
     |
     v
Vendor Dashboard
```

---

## 📅 Booking Status Flow

```text
Confirmed
    |
    v
 Active
    |
    v
Completed
```

A confirmed booking can also be cancelled according to the application's business rules.

---

## 💳 Payment Status

The current implementation assigns payment status based on the selected payment method.

```text
UPI
 |
 v
Completed


Cash
 |
 v
Pending
```

> **Note:** No external payment gateway is integrated in the current version.

---

## 🏗️ Architecture

The application follows **MVC architecture** with the **DAO design pattern**.

```text
                    Browser
                       |
                       v
                      JSP
                       |
                       v
             Servlet / Controller
                       |
                       v
                 DAO Interface
                       |
                       v
              DAO Implementation
                       |
                       v
                     JDBC
                       |
                       v
                    MySQL
```

---

## 🧩 MVC Structure

```text
Model
 |
 +-- Java Model / POJO Classes


View
 |
 +-- JSP
 +-- CSS
 +-- JavaScript


Controller
 |
 +-- Jakarta Servlets
```

---

## 🗄️ DAO Structure

```text
Servlet
   |
   v
DAO Interface
   |
   v
DAO Implementation
   |
   v
JDBC
   |
   v
MySQL
```

---

## 🛠️ Technology Stack

| Technology          | Version / Usage               |
| ------------------- | ----------------------------- |
| Java                | 21                            |
| Apache Tomcat       | 11                            |
| Jakarta Servlet API | 6.0                           |
| JSP                 | JavaServer Pages              |
| JSTL                | JSP Standard Tag Library      |
| Maven               | Build & Dependency Management |
| MySQL               | Database                      |
| JDBC                | Database Connectivity         |
| BCrypt              | Password Hashing              |
| HTML5               | Frontend                      |
| CSS3                | Styling                       |
| JavaScript          | Client-side Validation        |

---

## 📁 Project Structure

```text
DriveWay/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/vrs/
│       │       ├── config/
│       │       ├── controller/
│       │       ├── dao/
│       │       ├── model/
│       │       └── utility/
│       │
│       └── webapp/
│           ├── admin/
│           ├── customer/
│           ├── vendor/
│           ├── common/
│           ├── css/
│           ├── js/
│           ├── image/
│           ├── index.jsp
│           ├── login.jsp
│           ├── register.jsp
│           └── vendor-register.jsp
│
├── docs/
│   └── screenshots/
│
├── pom.xml
├── .gitignore
└── README.md
```

---

## 🗃️ Database

The application uses **MySQL** with the following database:

```sql
vehicle_rental_system
```

### Main Entities

* Users
* Vendors
* Vehicles
* Bookings
* Reviews

The database uses:

* Primary keys
* Foreign keys
* Unique constraints
* Enum values
* Referential integrity

to maintain data integrity and enforce business rules.

---

## 🔒 Authentication & Security

DriveWay implements several security mechanisms:

* Passwords are stored using **BCrypt hashing**
* Role-based authorization controls access to protected modules
* Vendor accounts require administrator approval
* Inactive customer accounts cannot authenticate
* Servlet-side validation enforces backend business rules
* Client-side JavaScript validation provides immediate feedback where required

> **Security Note:** Never commit real database passwords, API keys, or other sensitive credentials to GitHub.

---

## 🧪 Application Testing Flow

### Customer Flow

```text
Customer Registration
        |
        v
      Login
        |
        v
Browse Vehicles
        |
        v
View Vehicle Details
        |
        v
Book Vehicle
        |
        v
My Bookings
        |
     +--+----------------+
     |                   |
     v                   v
Cancel Booking      Submit Review


```

### Vendor Flow

```text
Vendor Registration
        |
        v
Pending Approval
        |
        v
Admin Approval
        |
        v
Vendor Login
        |
        v
Vendor Dashboard
        |
   +----+------------------+
   |                       |
   v                       v
Manage Vehicles      Manage Bookings
   |
   v
Manage Vendor Profile


```

### Admin Flow

```text
Admin Login
     |
     v
Admin Dashboard
     |
     +-- Manage Users
     |      |
     |      +-- Activate Customer
     |      +-- Deactivate Customer
     |
     +-- Manage Vendors
     |      |
     |      +-- Approve Vendor
     |      +-- Reject Vendor
     |
     +-- View Vehicles
     |
     +-- View Bookings
     |
     +-- View Reviews
```

---

## 🚀 Future Improvements

The following features can be considered for future versions:

* Online payment gateway integration
* Vendor image upload through the web application
* Improved vehicle search and filtering
* Pagination
* Email notifications
* Advanced reporting and analytics
* Persistent external image storage
* Production deployment configuration
* Additional security hardening

---

## 📋 Prerequisites

Before running the application, install the following:

* **JDK 21**
* **Apache Tomcat 11**
* **MySQL Server**
* **MySQL Workbench**
* **Maven**
* **Eclipse IDE** or another Java-compatible IDE

---

## ⚙️ Installation

### 1. Clone the Repository

```bash
git clone https://github.com/AJEEF-k/Vehicle-Rental-System.git
```

```bash
cd Vehicle-Rental-System
```

---

### 2. Import the Project

Import the repository into **Eclipse** as a Maven project.

In Eclipse:

```text
File
  → Import
  → Maven
  → Existing Maven Projects
```

Select the cloned project and finish the import.

---

### 3. Create the Database

Open MySQL Workbench or the MySQL command line and create the database:

```sql
CREATE DATABASE vehicle_rental_system;
```

If a database SQL script is included in the project, import or execute it after creating the database.

---

### 4. Configure MySQL

Update the application's database connection configuration with your local MySQL credentials.

Example:

```text
Database Name: vehicle_rental_system
Username: your_mysql_username
Password: your_mysql_password
```

> **Important:** Do not commit real database credentials to GitHub.

---

### 5. Update Maven Dependencies

In Eclipse:

```text
Right-click Project
    → Maven
    → Update Project
```

Alternatively, run:

```bash
mvn clean install
```

---

### 6. Configure Apache Tomcat

Configure the project with:

```text
Java Version       : 21
Apache Tomcat      : 11
Jakarta Servlet    : 6.0
```

Add the project to the Tomcat server and deploy it.

---

### 7. Run the Application

Start the Tomcat server and open:

```text
http://localhost:8080/Vehicle_Rental_System/
```

---

## 👨‍💻 Author

**Ajeef K**

This project was developed as a Java web application using:

* Java
* JSP
* Jakarta Servlets
* MVC
* DAO
* JDBC
* MySQL
* Maven

---

## 📄 License

This project is licensed under the **MIT License**.
