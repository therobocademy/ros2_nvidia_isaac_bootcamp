# ros2_nvidia_isaac_bootcamp
This repository has docker compose files to get started with the bootcamp

## System Prerequisites

For a local setup, use a machine with:
- Ubuntu 22.04 or Ubuntu 24.04 (dual-boot is supported)
- NVIDIA RTX 3050 or better
- More than 6 GB GPU VRAM

If you are using Windows or macOS and do not have a compatible local Linux + NVIDIA setup, you can use a cloud GPU service such as [vast.ai](https://vast.ai/).

## Docker Installation

This section explains how to install Docker so you can run the bootcamp containers.
For Ubuntu, a script is provided for automatic installation.
For Windows, follow the WSL + Docker Desktop steps.

### Ubuntu 24.04 and 22.04

Run the setup script (automatic installation):

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

## Start Docker Compose (GUI Enabled)

The compose file is already configured for GUI forwarding with:
- `DISPLAY`
- `~/.Xauthority`
- `/tmp/.X11-unix`

### Ubuntu 22.04 / 24.04

From your host terminal:

```bash
cd ros2_nvidia_isaac_bootcamp
xhost +local:docker
touch ~/.Xauthority
docker compose up -d
docker compose exec workshop bash
```

Then launch your GUI app inside the container (for example, `rviz2` or Isaac Sim command used in the workshop).

### Windows 11 (WSL2 + WSLg)

Run these commands inside your Ubuntu WSL terminal (not PowerShell):

```bash
cd ros2_nvidia_isaac_bootcamp
xhost +local:docker
touch ~/.Xauthority
docker compose up -d
docker compose exec workshop bash
```

Notes for Windows 11:
- Start Docker Desktop before running `docker compose`.
- Make sure WSL integration is enabled for your Ubuntu distro in Docker Desktop.
- GUI windows appear through WSLg on Windows.


## Dev Container (VS Code)

This repo includes:
- `docker-compose.yml`
- `.devcontainer/devcontainer.json`

Use it in VS Code:
1. Install the `Dev Containers` extension.
2. Open this repository in VS Code.
3. Run `Dev Containers: Reopen in Container`.
