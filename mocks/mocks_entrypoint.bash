#!/bin/bash

# WARNING: kills all background jobs *in this shell session* after execution

OUTPUT_DIR="mock_output"

declare -A TOPICS_DICT=(
  [/environment/pressure]=sensor_msgs/msg/FluidPressure
  [/environment/temperature]=sensor_msgs/msg/Temperature
  # [/image/image_raw]=sensor_msgs/msg/Image
  [/coordinates]=geometry_msgs/msg/Pose2D
  [/leds]=std_msgs/msg/Float32
  [/commands/leds]=std_msgs/msg/Float32
  [/commands/camera/rotation]=geometry_msgs/msg/Vector3
  [/commands/camera/height]=std_msgs/msg/Int8
  [/commands/move]=geometry_msgs/msg/Vector3
)


mkdir -p ${OUTPUT_DIR}

TOPICS="${!TOPICS_DICT[@]}"
echo "Collecting to \"$OUTPUT_DIR\" outputs from: $TOPICS"

for topic_ in $TOPICS; do
    type_=${TOPICS_DICT[$topic_]}
    PYTHONUNBUFFERED=yes ros2 topic echo --csv $topic_ $type_ &> ${OUTPUT_DIR}/log${topic_//\//_}.csv &
done

source ros2_ws/install/setup.sh
ros2 run mock_publishers mock &
ros2 run camera_simulator camera_simulator --type video --path /app/video.mp4 &

wait

jobs -p | xargs kill -9 &> /dev/null
echo 'Finished mocking'
