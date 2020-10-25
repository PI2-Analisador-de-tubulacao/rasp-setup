# raspi-setup

Repository to keep playbooks and configuration files for the raspberry used in this project.

_Note: All configuration steps were executed direct in the raspberry or using other Linux environment_

## Requirements

The setup were tested in a Raspberry 3 which had this initial setup:

* **Raspbian installed** (was used Buster version, from 2020-08-20)

* **SSH server enabled:** To do it, just create a `ssh` empty file at the root of the boot partition (the one without `/etc`, `/opt`, etc.).
This can be done by mounting this partition as soon as the OS image was written to the SD card, before turning on the device.

## Running networking setup

**You will lose internet access in raspi after that.** So, better run this after the rest of the configuration is done

There is an Ansible playbook for it. To execute it, follow this steps from an computer which can reach raspi:

1. **[Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#selecting-an-ansible-version-to-install) if you don't have it yet**
2. **Modify the [hosts](./hosts) file to match your raspi IP address**

One easy option is to connect the raspberry to your router via ethernet cable and check the router configuration looking for the raspi IP address

3. **Run the command:**
``` bash
# Flags about password, because I'm assuming you don't have any SSH keys set up
$ ansible-playbook -i hosts -K --ask-pass setup_network.yml

# If the command hangs for too long, you can try to running it again (if there is still network connection)
```

If no errors happen, the Raspberry should have the static IP address `192.158.200.1/24` and will put
devices connected to it through ethernet cable at the same network.

_Note1: The Wi-Fi connection is lost after this setup success and extra configuration is needed to make it to work again (not necessary for this project)_

_Note2: Wi-Fi won't work with this configuration and no DNS or gateway configurations are executed (not necessary for this project)_
