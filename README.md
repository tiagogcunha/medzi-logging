# Centralized Logging Setup with Loki, Promtail, and Grafana

This setup provides centralized logging using the Grafana stack:
- Loki: Log aggregation system
- Promtail: Log collector and forwarder
- Grafana: Visualization and querying interface

## Quick Start

### 1. Environment Setup
Copy the example environment file and set your credentials:
```bash
cp .env.example .env
```

Edit `.env` file to set your credentials:
```env
GRAFANA_USER=your_username
GRAFANA_PASSWORD=your_secure_password
```

### 2. Setup Script
Run the setup script to create necessary directories:

```bash
./setup.sh
```

Or manually create the directories:
```bash
# Create Loki data directories
mkdir -p loki-data/{wal,index,chunks,compactor,boltdb-cache}
chmod -R 777 loki-data
```

### 3. Start the Stack
```bash
docker-compose up -d
```

### 4. Access Grafana
- Open `http://localhost:3200` in your browser
- Login with the credentials you set in `.env`

## Adding New Log Sources

### 1. Update Promtail Configuration
Edit `promtail-config.yaml` to add new log sources. Example structure:

```yaml
scrape_configs:
  - job_name: new_log_source
    static_configs:
      - targets:
          - localhost
        labels:
          job: application_name
          app: service_name
          __path__: /path/to/your/logs/*.log
```

### 2. Key Components for New Sources:
- `job_name`: Unique identifier for this log source
- `labels`: Add relevant labels to help query logs
  - `job`: Type of application/service
  - `app`: Specific application name
- `__path__`: Path to log files (supports wildcards)

### 3. Restart Promtail
After adding new sources:
```bash
docker-compose restart promtail
```

## Querying Logs

In Grafana:
1. Go to Explore (Compass icon)
2. Select "Loki" datasource
3. Use LogQL to query logs:
   - `{app="medzi_app"}`: All logs from medzi app
   - `{job="medzi_application"}`: All application logs
   - `{app="medzi_app"} |= "error"`: All error logs

## Directory Structure
```
.
├── docker-compose.yaml
├── loki-config.yaml
├── promtail-config.yaml
├── setup.sh
└── loki-data/
    ├── wal/
    ├── index/
    ├── chunks/
    ├── compactor/
    └── boltdb-cache/
```

## Ports
- Grafana: `3200` (Web Interface)
- Loki: `3100` (API Endpoint)
```

And here's the setup script:

```bash:setup.sh
#!/bin/bash

# Create Loki data directories
echo "Creating Loki data directories..."
mkdir -p loki-data/{wal,index,chunks,compactor,boltdb-cache}
chmod -R 777 loki-data

echo "Setup complete! You can now run: docker-compose up -d"
```

Don't forget to make the script executable:
```bash
chmod +x setup.sh
```

This README provides:
1. Step-by-step setup instructions
2. How to add new log sources
3. Basic querying information
4. Directory structure explanation
5. Port information

The setup script automates the directory creation process, making it easier to get started.
