# Galaxy Server Configuration

This repository contains the Docker Compose configuration and management scripts for deploying a **Galaxy Server** (v24.2+).

## 🚀 Quick Start

### 1. Requirements
*   **Docker Engine** (v20.10+)
*   **Docker Compose** (v2.0+)
*   4 CPU Cores & 8GB RAM (Minimum recommended)

### 2. Setup
1.  **Clone the repository**:
    ```bash
    git clone <your-repo-url>
    cd galaxy-server
    ```

2.  **Configure Environment**:
    Copy the example environment file (or create one):
    ```bash
    cp .env.example .env
    ```
    *Note: Ensure `HOST_PORT`, `ADMIN_EMAIL`, and passwords are set in `.env`.*

3.  **Start Galaxy**:
    ```bash
    docker compose up -d
    ```

4.  **Access the Interface**:
    Open your browser and navigate to: `http://localhost:8080` (or your configured IP/Port).
    * Initial startup may take 5-10 minutes.

---

## 📂 Project Structure

```text
├── config/             # Galaxy configuration files
│   ├── job_conf.xml    # Resource limits & runner config
│   └── tool_list.yaml  # List of tools to install automatically
├── scripts/            # Automation & maintenance scripts
│   ├── backup_galaxy.sh
│   ├── install_tools.sh
│   └── wait-for-galaxy.sh
├── data/               # Persistent data store (Note: gitignored)
├── docker-compose.yml  # Main service definition
└── .env                # Secrets and environment variables
```

## 🛠️ Management Scripts

All scripts are located in the `scripts/` directory.

### Health Check
Wait for the server to auto-configure and become responsive:
```bash
./scripts/wait-for-galaxy.sh [URL] [TIMEOUT]
# Example:
./scripts/wait-for-galaxy.sh http://localhost:8080
```

### Tool Installation
Install tools defined in `config/tool_list.yaml` using Ephemeris:
```bash
# Requires: pip install ephemeris
./scripts/install_tools.sh
```

### Backups
Create a compressed archive of `data/`, `config/`, and `.env` in `backups/`:
```bash
./scripts/backup_galaxy.sh
```

## ⚙️ Configuration

### Resource Limits
Resource limits are defined in two places:
1.  **Docker Container** (`docker-compose.yml`): Hard limit for the container.
2.  **Galaxy Job Scheduler** (`config/job_conf.xml`): Job-specific limits (currently **4 Cores / 8GB RAM** per job) to prevent server overload.

### Git Ignore
The `.gitignore` is configured to exclude:
*   `data/` (Heavy genomic data)
*   `.env` (Secrets)
*   `backups/` (Local archives)
