# Docker Images Deployment with Ansible

This project automates Docker image deployment on servers using Ansible. The infrastructure is deployed on Yandex.Cloud using managed services.

## Application link
www.devops-rinat.fun

### Hexlet tests and linter status:
[![Actions Status](https://github.com/talveRinat/devops-for-programmers-project-76/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/talveRinat/devops-for-programmers-project-76/actions)


## Cloud Infrastructure

The project uses the following Yandex.Cloud services:

1. Application Load Balancer (ALB)

2. Managed Service for PostgreSQL

3. Compute Cloud (Virtual Machines)
   - Two virtual machines for web servers


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
   make add-ansible
   ```

This will:
- Create a new virtual environment with Python 3.12 in `.venv`
- Install Ansible using uv

## Project Structure

```
.
├── Makefile               # Automation commands
├── README.md              # Project documentation
├── ansible.cfg
├── deploy.yml             # Server deployment playbook
├── group_vars             # Variables directory
│   ├── all.yml            # Ansible config
│   └── webservers
│       ├── vars.yml       # Server config
│       └── vault.yml
├── inventory.ini          # Server inventory file
├── playbook.yml           # Main playbook
├── requirements.yml       # Ansible Galaxy requirements
└── templates
    ├── datadog.yaml.j2
    └── redmine.env.j2      
```

## Initial Setup

1. Clone this repository
2. Rekeying Encrypted Files `group_vars/webservers/vault.yml`
2. Edit the `inventory.ini` file to specify your server IPs
3. Edit the `group_vars/all/vars.yml` file to specify ansible root name
4. Prepare ansible galaxy roles
   ```bash
   make ansible-roles
   ```
5. Prepare servers:
   ```bash
   make setup-servers
   ```

## Quick Start

1. Local Development:
   ```bash
   docker run -d --name redmine -p 3000:3000 redmine:latest
   ```

2. Production Deployment:
   ```bash
   # Deploy Redmine
   make deploy-services

   # Add datadog monitore service
   make add-datadog
   ```

## Notes

- The virtual environment is created in `.venv` directory using Python 3.12
- Always activate the virtual environment when running commands manually: `. .venv/bin/activate`
- Add `.venv` to your .gitignore file
- Add `.vault-pss` to your .gitignore file