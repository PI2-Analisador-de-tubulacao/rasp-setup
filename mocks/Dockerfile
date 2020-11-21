FROM ros:foxy-ros-base

WORKDIR /app

COPY ros2_ws ros2_ws

RUN apt update -y \
    && apt install -y python3-natsort \
    && cd ros2_ws \
    && rosdep install -i --from-path src --rosdistro foxy -y \
    && colcon build --symlink-install

COPY mocks_entrypoint.bash mocks_entrypoint.bash

CMD ["/bin/bash", "/app/mocks_entrypoint.bash"]
