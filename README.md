# DriveWay – Vehicle Rental System

DriveWay is a Java-based web application for renting and managing vehicles online. The system provides separate modules for customers, vendors, and system administrators with role-based authentication, authorization, vehicle management, booking management, and review functionality.

## Demo Video

<!-- Drag and drop your project demo video here while editing this README on GitHub. -->
<!-- GitHub will automatically insert the uploaded video reference below this line. -->


## Screenshots

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


## Project Overview

DriveWay allows customers to browse available vehicles, view vehicle details, make rental bookings, manage their bookings, and submit reviews.

Vendors can register their rental business, add and manage vehicles, manage vehicle availability, and handle customer bookings.

System administrators can manage customer accounts, approve or reject vendors, view vehicles and bookings, and monitor customer reviews.

The application follows the MVC architecture and DAO design pattern to separate presentation, controller, business, and database operations.


## Key Features

### Customer Module

- Customer registration and login
- Browse available vehicles
- Search vehicles
- View vehicle details
- Vehicle image display
- Book vehicles
- Select hourly or daily rental rates
- Select payment method
- View booking history
- Cancel eligible bookings
- Submit vehicle and vendor ratings
- Update profile
- Change password
- Account activation and deactivation support

### Vendor Module

- Dedicated vendor registration
- Vendor approval workflow
- Vendor login with authorization
- Vendor dashboard
- Add vehicles
- Edit vehicle details
- View vehicle images
- Manage vehicle operational status
- View customer bookings
- Start confirmed bookings
- Cancel confirmed bookings
- Complete active bookings
- Update vendor profile
- Change password

### Admin Module

- Admin login
- Admin dashboard
- View all users
- Activate or deactivate customer accounts
- View registered vendors
- Approve or reject vendor registrations
- View all vehicles
- View all bookings
- View customer reviews


## Role-Based Access Control

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
    
    
##Vendor Approval Workflow


New vendors cannot access vendor features until an administrator approves the vendor account.

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
    +---+---+
    |       |
 Approve  Reject
    |
    v
APPROVED
    |
    v
Vendor Login
    |
    v
Vendor Dashboard





##Booking Status Flow

Confirmed
    |
    v
Active
    |
    v
Completed

A confirmed booking can also be cancelled according to the application's business rules.



##Payment Status

The current implementation assigns payment status based on the selected payment method

UPI
 |
 v
Completed

Cash
 |
 v
Pending

No external payment gateway is integrated in the current version.



##Architecture

The application follows MVC architecture with the DAO design pattern.

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
                    
                    
                                      
##MVC Structure

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
 
 
 
 
##DAO Structure

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




##Technology Stack

Java 21
Apache Tomcat 11
Jakarta Servlet API 6.0
JSP
JSTL
Maven
MySQL
JDBC
BCrypt
HTML5
CSS3
JavaScript     




##Project Structure

DriveWay/
|
+-- src/
|   |
|   +-- main/
|       |
|       +-- java/
|       |   |
|       |   +-- com/vrs/
|       |       +-- config/
|       |       +-- controller/
|       |       +-- dao/
|       |       +-- model/
|       |       +-- utility/
|       |
|       +-- webapp/
|           +-- admin/
|           +-- customer/
|           +-- vendor/
|           +-- common/
|           +-- css/
|           +-- js/
|           +-- image/
|           +-- index.jsp
|           +-- login.jsp
|           +-- register.jsp
|           +-- vendor-register.jsp
|
+-- docs/
|   |
|   +-- screenshots/
|
+-- pom.xml
+-- .gitignore
+-- README.md




##Database

The application uses MySQL with the database:
vehicle_rental_system

The main entities include:

Users
Vendors
Vehicles
Bookings
Reviews

The database uses primary keys, foreign keys, unique constraints, and enum values to maintain data integrity and business rules.




##Authentication and Security

Passwords are stored using BCrypt hashing.
Role-based authorization controls access to protected modules.
Vendor accounts require administrator approval.
Inactive customer accounts cannot authenticate.
Servlet-side validation enforces backend business rules.
Client-side JavaScript validation provides immediate feedback where required.



##Application Testing Flow

###Customer

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
        +-- Cancel Booking
        |
        +-- Submit Review
        

###Vendor

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
        +-- Manage Vehicles
        |
        +-- Manage Bookings
        |
        +-- Manage Profile        


###Admin

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
        +-- View Bookings
        +-- View Reviews
        
        
        

##Future Improvements

Online payment gateway integration
Vendor image upload through the web application
Improved vehicle search and filtering
Pagination
Email notifications
Advanced reporting and analytics
Persistent external image storage
Production deployment configuration
Additional security hardening        



##Prerequisites

###Install:

JDK 21
Apache Tomcat 11
MySQL Server
MySQL Workbench
Maven
Eclipse IDE or another Java IDE


#Installation


##1.Clone the Repository

git clone https://github.com/AJEEF-k/Vehicle-Rental-System.git


##2.Import the Project

Import the repository into Eclipse as a Maven project.


##3.Create the Database

CREATE DATABASE vehicle_rental_system;

Import or execute the project's database SQL script, if available.



##4.Configure MySQL

Update the database connection configuration with your local MySQL credentials.

Do not commit real database passwords or other sensitive credentials to GitHub.

Update Maven Dependencies

Using Eclipse:

Right-click Project
→ Maven
→ Update Project



##4.Configure Tomcat

Java 21
Apache Tomcat 11
Jakarta Servlet 6.0

Deploy the project to Tomcat.


##5.Run the Application

http://localhost:8080/Vehicle_Rental_System/




## Author

Developed by **Ajeef K**

This project was developed as a Java web application using Java, JSP,
Jakarta Servlets, MVC, DAO, JDBC, MySQL, and Maven.




## License

This project is licensed under the **MIT License**.
