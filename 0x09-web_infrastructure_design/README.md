## 🌐 Infrastructure Components

### 1. What is a Server?
A **server** is a computer (or software system) that provides resources, data, services, or programs to other computers—known as **clients**—over a network. In this setup, the server hosts the website and handles requests from users.

---

### 2. What is the Role of the Domain Name?
A **domain name** (e.g., `www.foobar.com`) is a human-readable identifier that maps to the IP address of a server. It allows users to access a website without needing to remember its numeric IP address.

---

### 3. What Type of DNS Record is ‘www’ in `www.foobar.com`?
The `www` is a **subdomain**. It is commonly mapped in DNS using:
- An **A (Address) record** → Points `www.foobar.com` directly to an IP address.
- A **CNAME (Canonical Name) record** → Maps `www.foobar.com` to another domain name, such as `foobar.com`.

---

### 4. What is the Role of the Web Server?
A **web server** (e.g., **Nginx**, **Apache**) performs the following:
- Serves static files like HTML, CSS, JS
- Handles HTTPS encryption
- Forwards dynamic requests to the application server
- Manages routing and logs

---

### 5. What is the Role of the Application Server?
An **application server** runs backend logic. It:
- Executes dynamic code (e.g., Python, Node.js, PHP)
- Processes user input and handles logic
- Interacts with the database

Examples: **Gunicorn**, **uWSGI**, **Node.js**.

---

### 6. What is the Role of the Database?
A **database** stores persistent data such as:
- Users, orders, sessions
- Content for the site

Examples: **MySQL**, **PostgreSQL**, **MongoDB**.

---

### 7. How Does the Server Communicate With the User?
The server and client communicate using the **HTTP/HTTPS protocols** over **TCP/IP**. When a user accesses `www.foobar.com`, the browser sends an HTTP request to the server, which replies with a response rendered in the browser.

![alt text](Web_infrastructure0002.png)
![alt text](Web_infrastructure.png)
![alt text](Web_infrastructure0001.png)



## 🏗️ Infrastructure Specifics: Load Balancer, Clustering, and Redundancy

### ➕ For Every Additional Element, Why You Are Adding It

| Component | Purpose |
|----------|---------|
| **Load Balancer** | Distributes incoming traffic across multiple backend servers to ensure availability and reliability. |
| **Database Primary-Replica Cluster** | Increases database read performance and provides failover capabilities. |
| **Firewall** | Secures infrastructure by controlling traffic flow and blocking malicious access. |
| **HTTPS** | Encrypts data in transit, protecting user data and establishing trust. |
| **Monitoring System** | Detects failures, provides visibility, and helps with scaling and debugging. |

---

## 🔁 Load Balancer Distribution Algorithm

**Distribution Algorithm: Round Robin**

- The load balancer uses **Round Robin**, where it forwards each incoming request to the next available backend server in a circular order.
- Example:
  - Request 1 → Server A
  - Request 2 → Server B
  - Request 3 → Server C
  - Request 4 → Server A (restarts the cycle)

Other common algorithms include:
- **Least Connections**: sends traffic to the server with the fewest current connections
- **IP Hash**: routes based on client IP to maintain session persistence

---

## 🧭 Active-Active vs. Active-Passive Load Balancing

| Setup | Description | Use Case |
|-------|-------------|----------|
| **Active-Active** | All servers are running and sharing traffic simultaneously | High performance and redundancy |
| **Active-Passive** | Only the primary server handles traffic, the secondary remains on standby | Simpler to configure but with limited load capacity |

In **Active-Active**, traffic is balanced across all healthy nodes. If one fails, others continue to serve users.

In **Active-Passive**, the standby server is only activated if the active one fails, introducing a short failover time.

---

## 🗃️ How a Database Primary-Replica (Master-Slave) Cluster Works

- The **Primary (Master)** node handles **write** operations (INSERT, UPDATE, DELETE).
- **Replica (Slave)** nodes receive updates from the primary and handle **read** operations.
- Replication can be:
  - **Asynchronous** (eventual consistency)
  - **Semi-synchronous** (balance between performance and data integrity)

---

## ⚙️ Difference Between Primary and Replica Nodes (Application Perspective)

| Feature | Primary Node | Replica Node |
|--------|---------------|--------------|
| Handles Writes | ✅ | ❌ |
| Handles Reads  | ✅ | ✅ (used for load distribution) |
| Risk of Conflict | Possible if multiple primaries exist | None (read-only) |
| Failure Impact | Data loss if no replication | Can be promoted to primary if configured |

Applications must be aware of the database role:
- Writes must go to the **primary**
- Reads can be routed to **replicas** to improve performance

---

## ⚠️ Issues in This Infrastructure

### ❗ Single Points of Failure (SPOF)

- If the **load balancer** fails and there is no backup, all access is lost.
- If only one **primary database** exists and fails, **write operations stop**.
- No **failover** or clustering introduces fragility.

### ❗ Security Issues

- **No firewall** → The infrastructure is open to unauthorized access or attacks (e.g., brute-force, DDoS).
- **No HTTPS** → Data is transmitted in plaintext, exposing sensitive user information to eavesdropping.

### ❗ No Monitoring

- Without monitoring:
  - Server failures go unnoticed until users report
  - No insight into performance, traffic, or resource usage
  - Scaling or debugging becomes reactive and difficult

---

##  Recommendation
To improve this setup:
- Introduce **redundant components** (load balancer, DB, web/app servers)
- Add **firewalls** and **HTTPS**
- Deploy **monitoring tools** like Prometheus + Grafana or Datadog
- Enable **auto-failover** for databases and multi-zone deployment


## 🔧 Additional Infrastructure Considerations

### ➕ For Every Additional Element, Why You Are Adding It

| Element             | Purpose |
|---------------------|---------|
| **Load Balancer**   | Distributes incoming traffic across multiple servers to improve availability and scalability. |
| **Firewall**        | Protects the infrastructure by filtering unauthorized or malicious network traffic. |
| **HTTPS/SSL**       | Encrypts communication between users and the server for secure data transmission. |
| **Monitoring Tools**| Help track system health, performance, and usage metrics for proactive maintenance. |
| **Database Replication** | Ensures high availability and redundancy in case the primary database server fails. |
| **Separate Web, App, DB Servers** | Improves scalability and simplifies troubleshooting by decoupling responsibilities. |

---

## 🔐 What Are Firewalls For?

A **firewall** is a security system that controls incoming and outgoing network traffic. It:
- Blocks unauthorized access to the server
- Allows trusted traffic based on defined rules
- Helps prevent DDoS, intrusion, and data leakage

---

## 🔒 Why Is the Traffic Served Over HTTPS?

HTTPS (HTTP Secure):
- Encrypts data between the user and server using **SSL/TLS**
- Prevents **eavesdropping**, **data tampering**, and **man-in-the-middle attacks**
- Builds **trust** by showing the padlock icon in the browser
- Required for **SEO ranking** and **modern browsers**

---

## 📈 What Is Monitoring Used For?

Monitoring tools:
- Track server uptime, CPU/memory usage, disk space, network traffic
- Detect failures or anomalies
- Send alerts when performance drops or errors occur
- Support capacity planning and resource optimization

---

## 📊 How Does the Monitoring Tool Collect Data?

Monitoring tools (like Prometheus, Grafana, Nagios):
- Use **agents** or **exporters** installed on the server
- Pull or receive data at intervals via HTTP, SNMP, or logs
- Store metrics in a **time-series database**
- Visualize metrics on **dashboards**

---

## ❓ How to Monitor Web Server QPS (Queries Per Second)

To monitor QPS:
1. **Enable access logging** on your web server (e.g., Nginx, Apache)
2. Use tools like:
   - `GoAccess`, `AWStats` for log analysis
   - `Prometheus` with Nginx exporter
   - `Grafana` for dashboards
3. Set alerts if QPS exceeds a defined threshold

---

## ⚠️ Infrastructure Issues

### ❗ Terminating SSL at the Load Balancer Level

- If SSL is **terminated** at the load balancer, traffic between the load balancer and internal servers is **unencrypted**.
- This may expose sensitive data **inside the network**.
- Solution: Use **end-to-end encryption** (TLS passthrough or re-encrypt at backend).

---

### ❗ Only One MySQL Server Accepting Writes

- If the **primary MySQL server** goes down, **no write operations** can occur.
- This creates a **single point of failure** and data loss risk.
- Solution: Use **MySQL replication** with **failover** or **clustered databases** like Galera Cluster.

---

### ❗ Servers With All the Same Components (Monolithic Setup)

- Every server runs web, app, and database components, which leads to:
  - **Resource contention**
  - **Scaling difficulties** (you can’t scale web without scaling DB too)
  - **Complex deployments and debugging**
- Solution: Use **tiered architecture**:
  - Web layer
  - Application layer
  - Database layer
