# raspi-setup

To keep playbooks and configuration files for the raspberry used in the project.

_Note: All configuration steps was made or direct in the raspberry or using a Linux environment_

## Requirements

The setup was tested in a raspberry 3 which had this initial setup:

* Install Raspbian
Was used Buster version, from 2020-08-20

* SSH server enabled
To do it, just create a `ssh` empty file at the root of the boot partition (the one without `/etc`, `/opt`, etc.)
Mount this partition as soon as the SO image was written to the SD card, before turning on the device

## Running networking configuration

**You will lose internet access in raspi after that.** So, better run this after the rest of the configuration is done

There is an Ansible playbook for it. So, just from an computer which can reach raspberry:

1. (Install Ansible)[https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#selecting-an-ansible-version-to-install] if you don't have it yet
2. Modify the (hosts)[./hosts] file to match your raspberry IP address
One easy option is to connect the raspberry to your router via ethernet and check it's configuration to look for the raspi IP address
3. Run the command:
``` bash
# Flags assuming you don't SSH keys set up
$ ansible-playbook -i hosts -K --ask-pass setup_network.yml

# If the command hangs for too long, you can try to run it again (if there is still connection)
```

If no errors, the raspberry should have the static `192.158.200.1/24` IP address and will give IPs
for every device connected through ethernet.

_Note1: Wi-Fi won't work with this configuration and no DNS or gateway configurations are made (not needed for this project)_
_Note2: The Wi-Fi connection is lost as soon as the playbook is executed_
