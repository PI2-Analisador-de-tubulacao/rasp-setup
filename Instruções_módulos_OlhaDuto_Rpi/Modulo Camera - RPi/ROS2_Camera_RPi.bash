## Adaptar o script para uso no --->> ROS 2.0
# Analisar como foi realizada esta implementação: https://gitlab.com/boldhearts/ros2_v4l2_camera
# https://index.ros.org/r/v4l2_camera/
# https://github.com/fkromer/awesome-ros2
# Outro exemplo que pode auxiliar: https://github.com/klintan/ros2_usb_camera/blob/dashing-devel/include/usb_camera_driver.hpp

# Conexão da cÂmera USB no RPI 3B+ com o ROS
# Referência: https://sudonull.com/post/14791-How-to-use-a-USB-camera-with-ROS-on-the-Raspberry-Pi-or-BeagleBone-Blue-for-streaming-video-to-a-lar
# Ethernet --- net_dev pode ser enpXXs0 ou ethX
$ ifconfig {net_dev} 
ifconfig enp61s0 
или просто ifconfig

# Usando o endereço IP como o valor para a variável ROS_IP
$ export ROS_IP="10.42.0.1"

# Exportando --- o ROS_MASTER_URI:
$ export ROS_MASTER_URI="http://10.42.0.1:11311"

# Salvando os valores em um arquivo .bashrc no diretório inicial
$ echo'export ROS_IP="10.42.0.1"' >> ~/.bashrc 
$ echo'export ROS_MASTER_URI="http://10.42.0.1:11311"' >> ~/.bashrc

# Conectando ao Raspberry Pi via ssh:
$ ssh {user}@{raspberry_ip} 

# Adicionando o endereço IP principal para ROS_MASTER_URI -- Na RPi, como um dispositivo escravo 
# Endereço IP do RPi 3B+ para ROS_IP
$ export ROS_IP="10.42.0.65" 
$ export ROS_MASTER_URI="http://10.42.0.1:11311" или    
$ echo'export ROS_IP="10.42.0.65"' >> ~/.bashrc 
$ echo'export ROS_MASTER_URI="http://10.42.0.1:11311"' >> ~/.bashrc

##### O sistema reconhece a camera em qualquer usb do dispositivo "escravo" automaticamente???????
# Conectar uma câmera USB e verifique se a câmera é reconhecida pelo sistema
$ lsusb 
$ ls /dev | grep video* 

# Instalar o nó ROS usb_cam com as dependências necessárias
$ sudo apt install ros-kinetic-usb-cam

# O nó usb_cam possui um arquivo de inicialização de teste
$ cat /opt/ros/kinetic/share/usb_cam/launch/usb_cam-test.launch

# Antes de enviar este arquivo, executar o kernel ROS no mestre
$ roscore

# Executar o nó usb_cam no escravo
$ roslaunch usb_cam usb_cam-test.launch

# Para ver os temas no terminal
$ rostopic list

# Na interface gráfica
$ rqt_graph

# Lendo os dados da câmera usando image_view:
$ rosrun image_view image_view image:=/usb_cam/image_raw


# Passando a tarefa em segundo plano para o primeiro plano
$ fg

# Streaming --- COMPARTILHAMENTO WEB
# Instalando o nó ROS do servidor de vídeo da web
$ sudo apt install ros-kinetic-web-video-server

# Criando um espaço de trabalho catkin para o arquivo de inicialização personalizado
$ mkdir -p ~/rosvid_ws/src 
$ cd ~/rosvid_ws 
$ catkin_make 
$ source devel/setup.bash

# Criando um pacote ROS
$ cd src
$ catkin_create_pkg vidsrv std_msgs rospy roscpp 

# Criando um arquivo de inicialização usando nano, vim, etc.
$ mkdir -p vidsrv/launch
$ nano vidsrv/launch/vidsrv.launch 

# Monte o pacote
$ cd .. 
$ catkin_make 

# Executando o kernel ROS no mestre novamente
$ roscore

# Executando o arquivo de inicialização gerado
$ roslaunch vidsrv vidsrv.launch

# A porta padrão do servidor de vídeo da WEB é 8080
# Abrir URL no navegador da web: {RPi_IP}: 8080

