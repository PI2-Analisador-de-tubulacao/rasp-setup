## Instructions

The mock processes will be run inside a Docker container. This directory contains the files used to build that container image.
The image is also already available in DockerHub: [icaropires/pi2-raspi-ros-mock](https://hub.docker.com/repository/docker/icaropires/pi2-raspi-ros-mock/general)

### Running

Following, there is an example of how the container with the mocks can be executed. The video to be used to mock the camera must be named `video.mp4`
and be at the same folder as the `run_mocks` script. Then, run:

```bash
$ chmod +x run_mocks  # Only in the first time
$ ./run_mocks
```

with this, all mocks will be in execution.
