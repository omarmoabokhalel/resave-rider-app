# ♻️ ReSave Rider App

A mobile application built with **Flutter** for riders who collect recyclable items from users as part of the **ReSave** recycling system.

The app allows riders to:

* View available orders
* Accept and manage their assigned orders
* Confirm collection by entering actual weights
* Complete orders after delivery to the warehouse

---

## 📱 App Overview

**ReSave Rider** is a dedicated app for riders responsible for collecting recyclable materials from users and delivering them to the storage facility.

The application communicates with a **Laravel REST API** and follows a **Clean Architecture + BLoC** pattern for scalability and maintainability.

---

## 🚀 Main Features

### 🔐 Authentication

* Rider login using email & password
* Secure token-based authentication (Sanctum)

### 📦 Orders Management

Orders are divided into two main sections:

#### 1️⃣ Available Orders

* Orders with status `pending`
* No rider assigned yet
* Rider can accept the order

#### 2️⃣ My Orders

* Orders assigned to the logged-in rider
* Includes:

  * `assigned` → accepted but not collected
  * `collected` → items collected and weighed
  * `delivered` → order completed

---

### 🛠 Order Flow

pending → assigned → collected → delivered


| Status    | Description                              |
| --------- | ---------------------------------------- |
| pending   | Order created by user, waiting for rider |
| assigned  | Rider accepted the order                 |
| collected | Rider entered actual weights             |
| delivered | Order delivered to warehouse             |

---

### ⚖️ Weighing & Confirmation

* Rider enters the **actual weight** for each item
* System calculates:

  * Total quantity
  * Earned points
* Order status automatically changes to `collected`

---

### 📸 Item Images

* Each order item includes an image uploaded by the user
* Images are displayed in the order details screen
* Used for verification before collection

---

### ✅ Order Completion

* After delivery to warehouse
* Rider marks order as **completed**
* Status changes to `delivered`

---

## 🧱 Architecture

The app follows **Clean Architecture**:

lib/
│
├── core/
│   ├── api/
│   └── error/
│
├── features/
│   └── orders/
│       ├── data/
│       │   ├── models
│       │   ├── datasources
│       │   └── repositories
│       ├── domain/
│       │   ├── entities
│       │   └── usecases
│       └── presentation/
│           ├── bloc
│           └── pages
```

* **State Management:** BLoC
* **Networking:** Dio
* **Architecture:** Clean Architecture
* **UI Direction:** RTL (Arabic support)

---

## 🔗 API Endpoints Used

| Method | Endpoint                          | Description           |
| ------ | --------------------------------- | --------------------- |
| POST   | `/rider/login`                    | Rider login           |
| GET    | `/rider/orders`                   | Get all orders        |
| POST   | `/rider/order/{id}/accept`        | Accept order          |
| POST   | `/rider/order/{id}/update-weight` | Submit actual weights |
| POST   | `/rider/order/{id}/complete`      | Complete order        |

---

## 🛠 Technologies Used

* **Flutter**
* **Dart**
* **BLoC (flutter_bloc)**
* **Dio**
* **Laravel REST API**
* **MySQL**
* **Cloudinary (for images)**

---

## 🌍 Localization

* Arabic language support
* Right-to-left (RTL) layout enabled

---

## 📸 Screens 

> Login
> Orders List
> Order Details
> Weighing Page
> Order Completion



---

## 👨‍💻 Author

**Omar Mohamed Abokhalel**
Full Stack Developer | Flutter Developer | Mobile Applications
LinkedIn: *(https://www.linkedin.com/in/omarmoabokhalel)*

---

## 📌 Notes

* This app is part of the **ReSave Project**
* Designed for real-world recycling workflow
* Scalable and production-ready structure
