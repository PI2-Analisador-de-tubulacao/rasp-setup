#!/bin/bash

# WARNING: kills all background jobs *in this shell session* after execution

TOPICS="/topic /rosout"
OUTPUT_DIR="mock_output"

mkdir -p ${OUTPUT_DIR}

echo 'Starting collecting...'
for t in $TOPICS; do
    PYTHONUNBUFFERED=yes ros2 topic echo --csv $t > ${OUTPUT_DIR}/log${t//\//_}.csv &
done
echo 'Started! CTRL-C to stop'

wait

jobs -p | xargs kill -9
echo 'Finished collecting'
