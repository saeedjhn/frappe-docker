# Frappe Docker Development Environment

## About Frappe

[Frappe](https://frappeframework.com) is a full-stack web application framework written in Python and JavaScript.  
It is the core framework behind ERPNext and is designed for building business applications quickly with a
metadata-driven architecture.

Key characteristics:

- Full-stack (Backend + Frontend)
- Built on Python (Flask-like backend)
- Uses MariaDB as primary database
- Real-time capabilities via Redis + SocketIO
- Highly extensible via Apps system
- Multi-tenant (sites-based architecture)

---

## Stack Overview

This project runs a full Frappe development environment using Docker:

- MariaDB (Database)
- Redis (Cache / Queue / SocketIO)
- Frappe Bench Container
- Docker Compose orchestration

---

## Services

| Service        | Description            | Port(s)    |
|----------------|------------------------|------------|
| mariadb        | Database server        | 3306       |
| redis-cache    | Cache layer            | 6379       |
| redis-queue    | Background jobs queue  | 6379       |
| redis-socketio | Realtime communication | 6379       |
| frappe         | Frappe bench container | 8000, 9000 |

---

## Getting Started

### 1. Install uv (Optional)

Install `uv` for faster Python package management.

Official Documentation:

https://docs.frappe.io/framework/user/en/installation

---

### 2. Clone repository

```bash
git clone <repo-url>
cd <project-folder>
```

---

### 3. Start Docker Services

**All required infrastructure commands are already defined in the Makefile, so you don’t need to run raw Docker Compose
commands manually.**

Run the required infrastructure services:

```bash
make up
#or
docker compose up --build
```

This usually starts:

- Frappe
- MariaDB
- Redis
- Redis Queue
- Redis SocketIO
- Other required services

---

### 4. Enter the Workspace Container

Open a shell inside the workspace container:

```bash
docker exec -it frappe-bench bash
```

---

### 5. Initialize Bench Workspace

Create a new Frappe Bench workspace:

```bash
bench init --skip-redis-config-generation frappe-bench
```

Explanation:

- `bench init` creates a new Frappe environment
- `--skip-redis-config-generation` prevents automatic Redis config generation because Redis is already managed by Docker

---

### 6. Enter Bench Directory

```bash
cd frappe-bench
```

---

### 7. Configure Redis and Database Hosts

Run the following commands:

```bash
bench set-redis-cache-host redis://redis-cache:6379

bench set-redis-queue-host redis://redis-queue:6379

bench set-redis-socketio-host redis://redis-socketio:6379

bench set-config -g db_host mariadb
```

Explanation:

- Configure Redis Cache connection
- Configure Redis Queue connection
- Configure Redis SocketIO connection
- Configure MariaDB host

---

### 8. Start Frappe Development Server

```bash
bench start
```

The web server will start on:

```text
http://localhost:8000
```

At this point, no Site exists yet, so the server has nothing to serve.

The next steps are:

1. Create an App
2. Create a Site
3. Install the App on the Site

---

### Important Note

Do NOT close the terminal where `bench start` is running.

To run additional bench commands:

1. Open another terminal
2. Enter the container/workspace again
3. Go into the bench directory:

```bash
cd frappe-bench
```

Then run your additional commands from there.

---

## Basic Architecture

```text
Docker Services
    ↓
Bench Workspace
    ↓
Apps
    ↓
Sites
    ↓
Database + Users + Config
```

---

## Key Concepts

### Bench

The development/runtime environment.

### App

Your business logic package.

Example:

- notes
- library_management
- crm

### Site

A running isolated instance with:

- its own database
- its own users
- its own configuration

Example:

- notes.localhost
- company-a.localhost
