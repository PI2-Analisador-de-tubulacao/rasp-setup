FROM ros:foxy-ros-base

WORKDIR /app

RUN apt update -y \
    && apt install -y python3-natsort \
    && mkdir -p ros_ws/src \
    && git clone https://github.com/icaropires/ros2_video_streamer ros_ws/src/camera_simulator \
    && cd ros_ws \
    && rosdep install -i --from-path src --rosdistro foxy -y \
    && colcon build --symlink-install

COPY mocks_entrypoint.bash /app/mocks_entrypoint.bash

CMD ["/bin/bash", "/app/mocks_entrypoint.bash"]
