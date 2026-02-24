# Bootcamp: Robotics and AI for Beginners with ROS 2 & NVIDIA Isaac

This repository has docker compose files to get started with the [bootcamp](https://robocademy.com/courses/robotics-ai-from-scratch-ros-2-nvidia-isaac-bootcamp-696f2d1461b5f31af9b9fd95)

## Table of Contents

- [System Prerequisites](#system-prerequisites)
- [Optional: Native Install (Isaac Sim + ROS 2)](#optional-native-install-isaac-sim--ros-2)
- [Docker Installation](#docker-installation)
- [Cloud Setup using Vast.ai (Ubuntu 22.04 Desktop VM with GPU)](#cloud-setup-using-vastai-ubuntu-2204-desktop-vm-with-gpu)
- [Download Workshop Docker Image](#download-workshop-docker-image)
- [Start Docker Compose (GUI Enabled)](#start-docker-compose-gui-enabled)

## System Prerequisites

For a local setup, use a machine with:
- Ubuntu 22.04 or Ubuntu 24.04
- NVIDIA RTX 3050 or better
- More than 6 GB GPU VRAM

If you are using Windows or macOS and do not have a compatible local Linux + NVIDIA setup, you can use a cloud GPU service such as [vast.ai](https://vast.ai/).

## Optional: Native Install (Isaac Sim + ROS 2)

Use this section if you want to install Isaac Sim manually and install ROS 2 directly on your Ubuntu system (outside Docker).

### Download Isaac Sim (Manual)

Download Isaac Sim using this link: <a href="https://docs.isaacsim.omniverse.nvidia.com/5.1.0/installation/quick-install.html" target="_blank" rel="noopener noreferrer">Doc</a>

https://download.isaacsim.omniverse.nvidia.com/isaac-sim-standalone-5.1.0-linux-x86_64.zip

After downloading, extract it:

```bash
unzip isaac-sim-standalone-5.1.0-linux-x86_64.zip
```

### Install ROS 2 with One-Line Script

Repository:

https://github.com/runtimerobotics/ros2_oneline_install

Install ROS 2 Jazzy:

```bash
wget -c https://raw.githubusercontent.com/runtimerobotics/ros2_oneline_install/main/ros2_install_jazzy.sh && chmod +x ./ros2_install_jazzy.sh && ./ros2_install_jazzy.sh
```

Install ROS 2 Humble:

```bash
wget -c https://raw.githubusercontent.com/runtimerobotics/ros2_oneline_install/main/ros2_install_humble.sh && chmod +x ./ros2_install_humble.sh && ./ros2_install_humble.sh
```

## Docker Installation

This section explains how to install Docker so you can run the bootcamp containers.
For Ubuntu, a script is provided for automatic installation.
For Windows, follow the WSL + Docker Desktop steps.
For Vast.ai Ubuntu Desktop VM, Docker is already pre-installed.

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

## Cloud Setup using Vast.ai (Ubuntu 22.04 Desktop VM with GPU)

If you do not have a compatible local Linux + NVIDIA GPU, you can rent a cloud GPU using [Vast.ai](https://cloud.vast.ai/?ref_id=374137) and use the pre-configured Ubuntu Desktop VM template (GUI + Docker already installed).

### Step 1: Create a Vast.ai Account

Sign up at Vast.ai and add credits.

### Step 2: Choose Instance

- GPU: RTX 3060 / 3090 / A5000 or better
- VRAM: Minimum 12 GB (16+ GB recommended)
- Disk: >= 50 GB

### Step 3: Select Template

- Select **Ubuntu Desktop (VM)**
- This template includes GUI, NVIDIA drivers, and Docker pre-installed

### Step 4: Access Desktop via VNC (No SSH Required)

- Open Vast.ai dashboard
- Click your running instance
- Click **Open**
- This launches the Ubuntu Desktop in your browser (VNC/Web Desktop)
- Login password is often `password`; check the template README to confirm the current credentials.

### Step 5: Verify GPU inside Desktop Terminal

```bash
nvidia-smi
```

**Note:** Docker is already installed in the Ubuntu Desktop VM template. No installation needed.

## Download Workshop Docker Image

Run the following command in the terminal of the environment where you will run the workshop:
- Local Ubuntu PC terminal, OR
- Vast.ai Ubuntu Desktop VM terminal (inside the VNC desktop)

```bash
docker pull therobocademy/ros2_nvidia_workshop:latest
```

Important: If you are using Vast.ai, open the Ubuntu Desktop (VNC), then open Terminal and run the `docker pull` command there. Do not run it on your local PC if you plan to run the container inside the Vast.ai VM.

## Start Docker Compose (GUI Enabled)

The compose file supports Linux and Windows (WSL) GUI forwarding.

### Ubuntu 22.04 / 24.04 (X11)

From your host terminal:

```bash
sudo apt update
sudo apt install -y git

git clone https://github.com/therobocademy/ros2_nvidia_isaac_bootcamp.git

cd ros2_nvidia_isaac_bootcamp

xhost +local:docker

export DISPLAY=${DISPLAY:-:0}
export DOCKER_NETWORK_MODE=host

mkdir -p ~/docker/isaac-sim/cache/{kit,ov,pip,glcache,computecache} ~/docker/isaac-sim/{logs,data,documents}

docker compose up workshop
```
In Terminal 2 (For taking a new terminal for Docker container)

```
docker exec -it isaac-sim bash
```

### Vast.ai Ubuntu Desktop VM (VNC Desktop)

Open Terminal inside the Vast.ai Ubuntu Desktop (in browser VNC), then run:

```bash
sudo apt update
sudo apt install -y git

git clone https://github.com/therobocademy/ros2_nvidia_isaac_bootcamp.git

cd ros2_nvidia_isaac_bootcamp

xhost +local:docker

export DISPLAY=${DISPLAY:-:0}
export DOCKER_NETWORK_MODE=host

mkdir -p ~/docker/isaac-sim/cache/{kit,ov,pip,glcache,computecache} ~/docker/isaac-sim/{logs,data,documents}

docker compose up workshop
```
In Terminal 2 (For taking a new terminal for Docker container)

```
docker exec -it isaac-sim bash
```

### Windows 11/10 (WSL2 + Docker Desktop)

1. Start an X server on Windows (VcXsrv/X410) with access control disabled (or allow your WSL IP).
2. Run these commands in Ubuntu WSL terminal:

```bash
sudo apt update
sudo apt install -y git

git clone https://github.com/therobocademy/ros2_nvidia_isaac_bootcamp.git

cd ros2_nvidia_isaac_bootcamp

unset DISPLAY
unset DOCKER_NETWORK_MODE

mkdir -p ~/docker/isaac-sim/cache/{kit,ov,pip,glcache,computecache} ~/docker/isaac-sim/{logs,data,documents}

docker compose up workshop
docker exec -it isaac-sim bash
```

Notes for Windows:
- Compose defaults `DISPLAY` to `host.docker.internal:0.0` when `DISPLAY` is unset.
- Start Docker Desktop before `docker compose up`.
- Keep WSL integration enabled for your Ubuntu distro.

Then launch your GUI app inside the container (for example, `rviz2` or Isaac Sim command used in the workshop).

## Possible Issues

If you see:

```text
Failed to create texture cache in /isaac-sim/.cache/ov/texturecache
Failed to create texture cache folder /isaac-sim/.cache/ov/texturecache
```

Run:

```bash
chmod -R 777 ~/docker/isaac-sim
```
