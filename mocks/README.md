## Instructions

The mock processes will be run inside a Docker container. This directory contains the files used to build that container image.
The image is also already available in DockerHub: [icaropires/pi2-raspi-ros-mock](https://hub.docker.com/repository/docker/icaropires/pi2-raspi-ros-mock/general)

### Running

Following, there is an example of how the container with the mocks can be executed. This command assumes that
the video you want to use as mock is named `my_video.mp4` and is located in your current directory:

```bash
$ docker run --rm --net=host -v "$PWD/my_video.mp4:/app/video.mp4" icaropires/pi2-raspi-ros-mock
```

After the command execution, the frames of the video will start being sent to the topic `/image/camera_info`
and the message type is `sensor_msgs/msg/Image`.

_Note: Currently the container contains only the mock for the camera_
