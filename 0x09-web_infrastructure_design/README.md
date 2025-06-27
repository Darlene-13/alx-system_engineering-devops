# Task 0: Simple Web Stack

This task involves designing a basic web infrastructure on a single server with a LAMP-like stack. Below is a breakdown of the key concepts and limitations of such an architecture.

![Simple Web Stack Diagram](0x09-web_infrastructure_design/Web-Infrastructure.png)
---

## 🧠 Conceptual Explanations

### 🖥️ What is a Server?
A **server** is a powerful computer designed to provide services or resources to other devices (clients) over a network. In this context, it runs the **web**, **application**, and **database** layers of the website.

---

### 🌍 What is the Role of the Domain Name?
The **domain name** (e.g., `foobar.com`) maps human-readable names to IP addresses (like `8.8.8.8`), so users don't have to remember numbers. It allows access to the website through a simple name instead of an IP address.

---

### 📛 What Type of DNS Record is `www` in `www.foobar.com`?
The `www` part is a **subdomain**, and its DNS record is typically an **A (Address) Record**, which maps it to the server's IP address (`8.8.8.8`).

---

### 🌐 What is the Role of the Web Server (Nginx)?
**Nginx** handles **HTTP(S)** requests from clients. It serves static files (HTML, CSS, images) and forwards dynamic requests to the application server.

---

### ⚙️ What is the Role of the Application Server?
The **application server** (e.g., PHP, Node.js) runs the **backend logic** of your website, such as user authentication, data processing, and interaction with the database.

---

### 🗃️ What is the Role of the Database?
The **MySQL database** stores structured data such as user accounts, posts, and transactions. The application server queries it to retrieve or modify data.

---

### 📡 How Does the Server Communicate with the User’s Computer?
Communication happens over **HTTP/HTTPS protocols**, using **TCP/IP** as the underlying transport layer. Nginx listens on port **80 (HTTP)** or **443 (HTTPS)** for incoming traffic.

---

## ⚠️ Weaknesses of This Infrastructure

1. **SPOF (Single Point of Failure)**  
   If the only server fails, everything goes down — the site becomes inaccessible.

2. **Downtime During Maintenance**  
   Restarting services like Nginx or deploying new code results in temporary service unavailability.

3. **Scalability Issues**  
   The setup cannot handle large volumes of traffic easily — the single server has limited CPU, RAM, and network capacity.

---
