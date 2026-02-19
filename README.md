# ros2_nvidia_isaac_bootcamp
This repository has docker compose files to get started with the bootcamp

## System Prerequisites

For a local setup, use a machine with:
- Ubuntu 22.04 or Ubuntu 24.04
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
docker pull therobocademy/ros2_nvidia_workshop:latest
```

## Start Docker Compose (GUI Enabled)

The compose file supports Linux and Windows (WSL) GUI forwarding.

### Ubuntu 22.04 / 24.04 (X11)

From your host terminal:

```bash
git clone https://github.com/therobocademy/ros2_nvidia_isaac_bootcamp.git

cd ros2_nvidia_isaac_bootcamp

xhost +local:docker

export DISPLAY=${DISPLAY:-:0}
export DOCKER_NETWORK_MODE=host

docker compose up workshop
docker exec -it isaac-sim bash

```

### Windows 11/10 (WSL2 + Docker Desktop)

1. Start an X server on Windows (VcXsrv/X410) with access control disabled (or allow your WSL IP).
2. Run these commands in Ubuntu WSL terminal:

```bash
git clone https://github.com/therobocademy/ros2_nvidia_isaac_bootcamp.git

cd ros2_nvidia_isaac_bootcamp

unset DISPLAY
unset DOCKER_NETWORK_MODE

docker compose up workshop
docker exec -it isaac-sim bash
```

Notes for Windows:
- Compose defaults `DISPLAY` to `host.docker.internal:0.0` when `DISPLAY` is unset.
- Start Docker Desktop before `docker compose up`.
- Keep WSL integration enabled for your Ubuntu distro.

Then launch your GUI app inside the container (for example, `rviz2` or Isaac Sim command used in the workshop).
