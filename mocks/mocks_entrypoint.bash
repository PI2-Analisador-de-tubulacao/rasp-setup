#!/bin/bash

# WARNING: kills all background jobs *in this shell session* after execution

TOPICS="/environment/pressure /environment/temperature /image/image_raw /coordinates /leds /commands/leds /commands/camera/rotation /commands/move"
OUTPUT_DIR="mock_output"

mkdir -p ${OUTPUT_DIR}

echo 'Starting collecting...'
for t in $TOPICS; do
    echo "Running collector for topic $t..."
    PYTHONUNBUFFERED=yes ros2 topic echo --csv $t &> ${OUTPUT_DIR}/log${t//\//_}.csv \
    || echo "Failed. Does topic $t exists?" \
    &
done

source ros2_ws/install/setup.sh
ros2 run mock_publishers mock &
ros2 run camera_simulator camera_simulator --type video --path /app/video.mp4 &

wait

jobs -p | xargs kill -9 &> /dev/null
echo 'Finished mocking'
