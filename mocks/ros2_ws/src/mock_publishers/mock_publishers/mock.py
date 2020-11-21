from math import pi
from random import randint, random

import rclpy
from rclpy.node import Node

from std_msgs.msg import Float32
from sensor_msgs.msg import FluidPressure, Temperature
from geometry_msgs.msg import Pose2D


class MockPublisher(Node):

    def __init__(self):
        super().__init__('mock_publisher')

        # TODO: attributes can jump to values not related to the past one,
        #   make it in increments
        self._to_publish = [
            (self.create_publisher(Pose2D, '/coordinates', 10),
                Pose2D(x=float(randint(-100, 100)), y=float(randint(-100, 100)), theta=random()*2*pi)),

            (self.create_publisher(FluidPressure, '/environment/pressure', 10),
                FluidPressure(fluid_pressure=float(randint(30000, 70000)))),

            (self.create_publisher(Temperature, '/environment/temperature', 10),
                Temperature(temperature=float(randint(0, 60)))),

            (self.create_publisher(Float32, '/leds', 10),
                Float32(data=random())),
        ]

        timer_period = 2
        self.timer = self.create_timer(timer_period, self.timer_callback)

    @property
    def topic_list(self):
        return [p.topic_name for p, _ in self._to_publish]

    def timer_callback(self):
        for publisher, msg in self._to_publish:
            publisher.publish(msg)


def main(args=None):
    rclpy.init(args=args)

    mock_publisher = MockPublisher()

    topic_names = ', '.join(mock_publisher.topic_list)
    mock_publisher.get_logger().info('Publishing to: %s' % topic_names)

    rclpy.spin(mock_publisher)


if __name__ == '__main__':
    main()
