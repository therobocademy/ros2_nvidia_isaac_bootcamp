# ros2_nvidia_isaac_bootcamp
This repository has docker compose files to get started with the bootcamp

## Docker Installation

### Ubuntu 24.04 and 22.04

Run the setup script:

```bash
wget https://raw.githubusercontent.com/therobocademy/ros2_nvidia_isaac_bootcamp/refs/heads/main/setup_docker_ubuntu.sh && chmod +x setup_docker_ubuntu.sh && sudo ./setup_docker_ubuntu.sh
```

Manual installation video for Ubuntu 24.04:

<p align="center">
  <a href="https://youtu.be/FWWq83IGUgw" target="_blank" rel="noopener noreferrer">
    <img src="https://img.youtube.com/vi/FWWq83IGUgw/hqdefault.jpg" alt="Docker install on Ubuntu 24.04" width="640" />
  </a>
</p>

Manual installation video for Ubuntu 22.04:

<p align="center">
  <a href="https://youtu.be/EuSVD7kVCUY" target="_blank" rel="noopener noreferrer">
    <img src="https://img.youtube.com/vi/EuSVD7kVCUY/hqdefault.jpg" alt="Docker install on Ubuntu 22.04" width="640" />
  </a>
</p>

Verify:

```bash
docker --version
```

### Windows 11/10 (WSL + Docker Desktop)

1. Install WSL (Ubuntu 24.04) in PowerShell (as Administrator):

```powershell
wsl --install -d Ubuntu-24.04
```

2. Install Docker Desktop:
https://www.docker.com/products/docker-desktop/

3. In Docker Desktop, enable:
`Settings -> Resources -> WSL Integration -> Ubuntu-24.04`

4. Verify:

```bash
docker --version
```

Windows 11 video:

<p align="center">
  <a href="https://youtu.be/fsR8fj7iCNY" target="_blank" rel="noopener noreferrer">
    <img src="https://img.youtube.com/vi/fsR8fj7iCNY/hqdefault.jpg" alt="Docker setup on Windows 11" width="640" />
  </a>
</p>

Windows 10 video:

<p align="center">
  <a href="https://youtu.be/kv2oQeg6MdE" target="_blank" rel="noopener noreferrer">
    <img src="https://img.youtube.com/vi/kv2oQeg6MdE/hqdefault.jpg" alt="Docker setup on Windows 10" width="640" />
  </a>
</p>

## Download Workshop Docker Image

```bash
docker pull ghcr.io/therobocademy/ros2_nvidia_workshop:latest
```

## Run With Docker Compose

Start the workshop container:

```bash
docker compose up -d
```

Open a shell inside it:

```bash
docker compose exec workshop bash
```

Stop it:

```bash
docker compose down
```

## Dev Container (VS Code)

This repo includes:
- `docker-compose.yml`
- `.devcontainer/devcontainer.json`

Use it in VS Code:
1. Install the `Dev Containers` extension.
2. Open this repository in VS Code.
3. Run `Dev Containers: Reopen in Container`.
