# Inception - System Administration Project

## 📌 Project Overview

**Inception** is a system administration project from the 42 curriculum. It introduces fundamental concepts of containerization and infrastructure orchestration using **Docker** and **Docker Compose**.

The objective is to set up a secure, containerized web infrastructure composed of multiple services such as **NGINX**, **WordPress**, and **MariaDB**—each running in its own container. All services are configured manually and built from scratch without relying on pre-built Docker images (except for Alpine or Debian as base images).

> ✅ This repository contains only the **mandatory part** of the project (no bonus services included).

---

## 📂 Project Structure

```bash
.
├── Makefile               # Build automation (run: `make`)
├── secrets/               # Credential storage (Docker secrets)
│   ├── db_password.txt
│   ├── db_root_password.txt
│   └── wp_admin_password.txt
│   └── wp_password.txt
└── srcs/
    ├── .env
    ├── docker-compose.yml # Container orchestration
    └── requirements/
        ├── mariadb/
        │   ├── Dockerfile    # Custom MariaDB image
        │   ├── conf/
        │   │   └── my.cnf    # MariaDB configuration
        │   └── tools/
        │       └── setup.sh  # DB initialization script
        ├── nginx/
        │   ├── Dockerfile    # Custom NGINX image
        │   └── conf/
        │       └── nginx.conf # NGINX configuration
        └── wordpress/
            ├── Dockerfile    # WordPress+PHP-FPM image
            └── tools/
                └── wp_conf.sh # WordPress setup script
```
---

## ⚙️ Technologies Used and 🛠️ features 
- Host Environment: Virtual Machine
- Docker & Docker Compose
- Base Images: Debian (penultimate stable version)
- Orchestration: Makefile-driven build process
- NGINX with TLSv1.2/1.3
- WordPress (PHP-FPM only)
- MariaDB
- OpenSSL (for HTTPS)
- Environment Variables with `.env` file support
- Fully containerized infrastructure with Docker Compose
- NGINX as the **sole entry point** via HTTPS (port 443 only)
- WordPress container using `php-fpm` (no web server inside)
- MariaDB container with proper user and database setup
- Persistent Storage: Dedicated volumes for database and website files
- Auto-recovery: Containers restart automatically on failure
- Strict compliance with Docker best practices
- Security Compliance: 
  - No credentials in Dockerfiles
  - Secure admin user naming conventions
  - Environment variables via `.env` + Docker secrets
---
## ⚙️ Technical Specifications

### Infrastructure Components
| Component        | Technology     | Port    | Details                      |
|------------------|----------------|---------|------------------------------|
| **Reverse Proxy** | NGINX          | 443     | TLS termination only         |
| **Application**   | WordPress      | 9000    | PHP-FPM processing           |
| **Database**      | MariaDB        | 3306    | Persistent volume storage    |
| **Network**       | Docker Bridge  | -       | Custom internal network      |

### Key Constraints Implemented
| Requirement Category | Implementation Status | Details |
|----------------------|------------------------|---------|
| **Image Sources**    | 🚫 Prohibited         | No pre-built images (except Alpine/Debian base) |
| **Networking**       | 🚫 Prohibited         | No `--links` or `network:host` |
| **Process Management** | 🚫 Prohibited         | No infinite-loop processes (`tail -f`, `sleep infinity`, etc.) |
| **Container Init**   | ✅ Implemented        | PID 1 best practices for proper initialization |
| **DNS Configuration** | ✅ Implemented        | Domain name routing (`yourlogin.42.fr`) |
| **Security**         | ✅ Implemented        | No credentials in Dockerfiles or version control |
| **TLS Protocols**    | ✅ Implemented        | TLSv1.2/TLSv1.3 only on NGINX |
| **Auto-recovery**    | ✅ Implemented        | Containers restart automatically on failure |


