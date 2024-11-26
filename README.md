# Docker Images Deployment with Ansible

This project automates Docker image deployment on servers using Ansible. The infrastructure is deployed on Yandex.Cloud using managed services.


### Hexlet tests and linter status:
[![Actions Status](https://github.com/talveRinat/devops-for-programmers-project-76/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/talveRinat/devops-for-programmers-project-76/actions)


## Cloud Infrastructure

The project uses the following Yandex.Cloud services:

1. Application Load Balancer (ALB)
   - Distributes incoming traffic between web servers
   - Provides SSL/TLS termination
   - Enables health checking for backend servers

2. Managed Service for PostgreSQL
   - Managed PostgreSQL cluster
   - Automated backups and maintenance
   - High availability configuration

3. Compute Cloud (Virtual Machines)
   - Two virtual machines for web servers
   - Located in different availability zones for redundancy

## Prerequisites

- Python 3.12
- uv package manager (`pip install uv`)
- Access to Yandex.Cloud services
- Access to target servers with root privileges

## Setting up Python Environment

This project uses `uv` for managing Python virtual environments and dependencies. Follow these steps to set up your environment:

1. Install uv if you haven't already:
   ```bash
   pip install uv
   ```

2. Create virtual environment and install dependencies:
   ```bash
   make deps
   ```

This will:
- Create a new virtual environment with Python 3.12 in `.venv`
- Install Ansible using uv

## Project Structure

```
.
├── inventory.ini      # Server inventory file
├── playbook.yml      # Main playbook
├── requirements.yml  # Ansible Galaxy requirements
├── group_vars/      # Variables directory
│   └── webservers.yml
├── Makefile         # Automation commands
└── README.md        # Project documentation
```

## Initial Setup

1. Clone this repository
2. Edit the `inventory.ini` file to specify your server IPs
3. Create Python environment and install dependencies:
   ```bash
   make deps
   ```
4. Prepare servers:
   ```bash
   make prepare
   ```

## Available Make Commands

- `make venv` - Creates Python 3.12 virtual environment using uv
- `make deps` - Creates venv and installs Ansible
- `make prepare` - Installs required Ansible Galaxy roles and executes the playbook

## Usage

Complete setup and server configuration:
```bash
make prepare
```

This will:
1. Create Python 3.12 virtual environment if not exists
2. Install Ansible using uv
3. Install required Ansible Galaxy roles
4. Execute the playbook to configure servers

## Notes

- The virtual environment is created in `.venv` directory using Python 3.12
- Always activate the virtual environment when running commands manually: `. .venv/bin/activate`
- Add `.venv` to your .gitignore file