FROM minaki/orb:ros-core

# install ros packages
RUN apt-get update && apt-get install -y \
    ros-kinetic-desktop=1.3.0-0* \
    && rm -rf /var/lib/apt/lists/*i

