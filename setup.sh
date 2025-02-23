#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Loki Stack Setup...${NC}\n"

# Check if .env file exists
if [ ! -f .env ]; then
    echo -e "${YELLOW}Creating .env file from example...${NC}"
    if [ -f .env.example ]; then
        cp .env.example .env
        echo -e "${GREEN}Created .env file. Please edit it with your credentials.${NC}\n"
    else
        echo -e "${YELLOW}Warning: .env.example not found. Creating empty .env file...${NC}"
        touch .env
        echo "GRAFANA_USER=admin" >> .env
        echo "GRAFANA_PASSWORD=your_secure_password" >> .env
        echo -e "${GREEN}Created .env file with default values. Please edit it with your credentials.${NC}\n"
    fi
fi

# Create Loki data directories
echo -e "${GREEN}Creating Loki data directories...${NC}"
mkdir -p loki-data/{wal,index,chunks,compactor,boltdb-cache}
chmod -R 777 loki-data

# Verify docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}Docker is not installed. Please install Docker first.${NC}"
    exit 1
fi

# Verify docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo -e "${YELLOW}Docker Compose is not installed. Please install Docker Compose first.${NC}"
    exit 1
fi

echo -e "\n${GREEN}Setup completed successfully!${NC}"
echo -e "\nNext steps:"
echo -e "1. Edit the .env file with your credentials"
echo -e "2. Run: docker-compose up -d"
echo -e "3. Access Grafana at http://localhost:3200" 