FROM nvcr.io/nvidia/isaac-sim:5.1.0

SHELL ["/bin/bash", "-c"]
USER root

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install base tools, locale, ROS 2 apt source, Gazebo apt source, and Isaac ROS apt source.
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg2 \
    lsb-release \
    locales \
    sudo \
    tzdata \
    software-properties-common \
    wget && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    add-apt-repository universe && \
    mkdir -p /etc/apt/keyrings /var/lib/apt/lists/partial && \
    wget -q https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    rm -f cuda-keyring_1.1-1_all.deb && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
      -o /etc/apt/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" \
      > /etc/apt/sources.list.d/ros2.list && \
    curl -sSL https://packages.osrfoundation.org/gazebo.gpg \
      -o /etc/apt/keyrings/gazebo-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/gazebo-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(. /etc/os-release && echo $UBUNTU_CODENAME) main" \
      > /etc/apt/sources.list.d/gazebo-stable.list && \
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc \
      | gpg --dearmor -o /etc/apt/keyrings/packages.microsoft.gpg && \
    chmod 0644 /etc/apt/keyrings/packages.microsoft.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
      > /etc/apt/sources.list.d/vscode.list && \
    curl -fsSL https://isaac.download.nvidia.com/isaac-ros/repos.key \
      | gpg --dearmor \
      | tee /usr/share/keyrings/nvidia-isaac-ros.gpg > /dev/null && \
    touch /etc/apt/sources.list.d/nvidia-isaac-ros.list && \
    s="deb [signed-by=/usr/share/keyrings/nvidia-isaac-ros.gpg] https://isaac.download.nvidia.com/isaac-ros/release-4.2 noble-jetpack main" && \
    grep -qxF "$s" /etc/apt/sources.list.d/nvidia-isaac-ros.list || echo "$s" | tee -a /etc/apt/sources.list.d/nvidia-isaac-ros.list && \
    curl -fsSL https://repo.download.nvidia.com/jetson/jetson-ota-public.asc \
      | gpg --dearmor \
      > /usr/share/keyrings/nvidia-jetson-ota.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/nvidia-jetson-ota.gpg] https://repo.download.nvidia.com/jetson/x86_64/noble r38.4 main" \
      > /etc/apt/sources.list.d/nvidia-jetson-apt-source.list

# Install ROS 2 Jazzy + Nav2 + MoveIt2 + OpenCV + new Gazebo (gz-harmonic).
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-jazzy-desktop-full \
    ros-jazzy-navigation2 \
    ros-jazzy-nav2-bringup \
    ros-jazzy-moveit \
    ros-jazzy-ur \
    ros-jazzy-ur-simulation-gz \
    ros-jazzy-urdf-tutorial \
    ros-jazzy-turtlebot3 \
    ros-jazzy-turtlebot3-simulations \
    ros-jazzy-rqt-robot-steering \
    ros-jazzy-ros2-control \
    ros-jazzy-ackermann-msgs \
    ros-jazzy-ros-testing \
    ros-jazzy-pointcloud-to-laserscan \
    python3-colcon-common-extensions \
    python-is-python3 \
    python3-rosdep \
    python3-vcstool \
    gz-harmonic \
    build-essential \
    git \
    vim \
    nano \
    code \
    ros-jazzy-usb-cam \
    ros-jazzy-rqt-image-view && \
    # Isaac ROS apt binaries are arm64-only in release-4.2 noble-jetpack as of 2026-03-12.
    # Install requested packages when present; skip on amd64 so the image still builds.
    for pkg in \
      ros-jazzy-isaac-ros-apriltag \
      ros-jazzy-isaac-ros-examples \
      ros-jazzy-isaac-ros-h264-decoder \
      ros-jazzy-isaac-ros-segment-anything \
      ros-jazzy-isaac-ros-segformer \
      ros-jazzy-isaac-ros-nvblox \
      ros-jazzy-isaac-ros-detectnet \
      ros-jazzy-isaac-ros-dnn-image-encoder \
      ros-jazzy-isaac-ros-triton \
      ros-jazzy-isaac-ros-grounding-dino \
      ros-jazzy-isaac-ros-grounding-dino-models-install \
      ros-jazzy-isaac-ros-yolov8 \
      ros-jazzy-isaac-ros-tensor-rt \
      ros-jazzy-isaac-ros-centerpose \
      ros-jazzy-isaac-ros-dope \
      ros-jazzy-isaac-ros-foundationpose \
      ros-jazzy-isaac-ros-visual-slam; do \
      if apt-cache show "$pkg" >/dev/null 2>&1; then \
        apt-get install -y --no-install-recommends "$pkg"; \
      else \
        echo "Skipping unavailable package on this architecture: $pkg"; \
      fi; \
    done && \
    for pkg in ros-jazzy-robot-steering ros-jazzy-steering-controllers ros-jazzy-ackermann-steering-controller; do \
      if apt-cache show "$pkg" >/dev/null 2>&1; then \
        apt-get install -y --no-install-recommends "$pkg"; \
      fi; \
    done && \
    for pkg in ros-jazzy-ros-gz ros-jazzy-gz-ros2-control ros-jazzy-ros-gzharmonic; do \
      if apt-cache show "$pkg" >/dev/null 2>&1; then \
        apt-get install -y --no-install-recommends "$pkg"; \
      fi; \
    done && \
    rosdep init || true && \
    test -f /opt/ros/jazzy/setup.bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV ROS_DISTRO=jazzy
ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp
ENV WORKSPACES_ROOT=/home/isaac-sim/workspaces
ENV ISAAC_ROS_WS=${WORKSPACES_ROOT}/isaac_ros-dev
ENV ISAACLAB_PATH=${WORKSPACES_ROOT}/IsaacLab
ENV ISAACSIM_ROS_WS=${WORKSPACES_ROOT}/IsaacSim-ros_workspaces
ENV ISAACSIM_PATH=/isaac-sim

RUN if id -u isaac-sim >/dev/null 2>&1; then \
      echo "isaac-sim ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/isaac-sim && \
      chmod 0440 /etc/sudoers.d/isaac-sim; \
    fi

RUN mkdir -p ${WORKSPACES_ROOT} && chown -R isaac-sim:isaac-sim ${WORKSPACES_ROOT}

USER isaac-sim

WORKDIR ${WORKSPACES_ROOT}

# Setup Isaac ROS workspace as the isaac-sim user.
RUN mkdir -p ${ISAAC_ROS_WS}/src && \
    cd ${ISAAC_ROS_WS}/src && \
    git clone --depth=1 https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_common.git && \
    git clone --depth=1 https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_nitros.git && \
    git clone --depth=1 https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_image_pipeline.git && \
    git clone --depth=1 https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_apriltag.git && \
    git clone --depth=1 https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_visual_slam.git

# Install Isaac Lab using Isaac Sim's Python runtime as the isaac-sim user.
RUN git clone --depth=1 https://github.com/isaac-sim/IsaacLab.git ${ISAACLAB_PATH} && \
    ln -sfn /isaac-sim ${ISAACLAB_PATH}/_isaac_sim && \
    /isaac-sim/python.sh -m pip install --user --no-cache-dir --upgrade pip setuptools wheel && \
    for pkg_dir in isaaclab isaaclab_tasks isaaclab_mimic; do \
      if [ -d "${ISAACLAB_PATH}/source/${pkg_dir}" ]; then \
        /isaac-sim/python.sh -m pip install --user --no-cache-dir -e "${ISAACLAB_PATH}/source/${pkg_dir}"; \
      fi; \
    done

# Build ROS 2 Jazzy workspace from IsaacSim-ros_workspaces as the isaac-sim user.
RUN git clone --depth=1 --recurse-submodules https://github.com/isaac-sim/IsaacSim-ros_workspaces.git ${ISAACSIM_ROS_WS} && \
    /bin/bash -c "source /opt/ros/jazzy/setup.bash && \
    cd ${ISAACSIM_ROS_WS}/jazzy_ws && \
    rosdep update && \
    rosdep install --from-paths src --ignore-src --rosdistro jazzy -r -y \
      --skip-keys='ackermann_msgs pointcloud_to_laserscan picknik_ament_copyright ros2_control_test_assets ros_testing ros2_control ros2_controllers'" && \
    /bin/bash -c "source /opt/ros/jazzy/setup.bash && \
    cd ${ISAACSIM_ROS_WS}/jazzy_ws && \
    colcon build --symlink-install \
      --packages-skip \
      cmdvel_to_ackermann \
      carter_navigation \
      iw_hub_navigation \
      isaac_ros_navigation_goal \
      h1_fullbody_controller \
      topic_based_ros2_control \
      moveit_resources_panda_description \
      moveit_resources_panda_moveit_config \
      isaac_moveit \
      moveit_resources"

RUN printf '%s\n' \
    "[ -f /opt/ros/jazzy/setup.bash ] && source /opt/ros/jazzy/setup.bash" \
    "export ISAAC_ROS_WS=\"\${ISAAC_ROS_WS:-\${HOME}/workspaces/isaac_ros-dev/}\"" \
    "[ -f ${ISAAC_ROS_WS}/install/setup.bash ] && source ${ISAAC_ROS_WS}/install/setup.bash" \
    "[ -f ${ISAACSIM_ROS_WS}/jazzy_ws/install/setup.bash ] && source ${ISAACSIM_ROS_WS}/jazzy_ws/install/setup.bash" \
    "export ISAACSIM_PATH=/isaac-sim" \
    "export ISAACLAB_PATH=${ISAACLAB_PATH}" \
    | sudo tee -a /isaac-sim/.bashrc >/dev/null && \
    sudo chown isaac-sim:isaac-sim /isaac-sim/.bashrc

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    jq \
    tar && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER isaac-sim

# Default entrypoint to launch headless with streaming
ENTRYPOINT ["/isaac-sim/runheadless.sh"]
