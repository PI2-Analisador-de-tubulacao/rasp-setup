from setuptools import setup

package_name = 'mock_publishers'

setup(
    name=package_name,
    version='0.0.1',
    packages=[package_name],
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='icaropires',
    maintainer_email='icaropsa@gmail.com',
    description='Package to mock most of publishers from Raspberry Pi from "Olhaduto" project',
    license='Apache License 2.0',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'mock = mock_publishers.mock:main'
        ],
    },
)
