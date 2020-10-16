#!/bin/bash
##
## script criado com a finalidade de instalar a GUI XFCE4 (Xubuntu desktop) em uma vps Ubuntu e configurar o acesso remoto via XRDP
## o acesso remoto pode ser feito utilizando o programa "area de trabalho remota" do Windows
## ou algum outro programa compativel com o protocolo RDP
##
##
echo "## atualizando repositorios..."
sudo apt -qq update -y
echo "## atualizando programas instalados..."
sudo apt -qq upgrade -y
echo "## instalando interface grafica..."
sudo apt -qq install xubuntu-core^ -y
echo "## instalando demais programas/dependencias..."
sudo apt -qq install xrdp xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils python3 python3-pip zip git ffmpeg thunar-archive-plugin firefox -y
echo "## terminando as configurações..."
sudo sed -i.bak '/fi/a #xrdp multiple users configuration \n xfce-session \n' /etc/xrdp/startwm.sh
sudo ufw allow 3389/tcp
sudo /etc/init.d/xrdp restart


echo "## deseja instalar o google chrome?(y/n) (o firefox já foi instalado)..."
read resposta
if [ resposta = "s" ]; then
    echo "## instalando..."
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt install ./google-chrome-stable_current_amd64.deb -y
	sudo apt -f install -y
	sudo rm -rf google-chrome-stable_current_amd64.deb
	echo "## "
	echo "## para utilizar o google chrome, voce precisará criar um novo usuario no sistema (google chrome nao abre no usuario root)"
	echo "## "
else
    echo ""
fi

echo "## ## tudo ok..."
echo "## deseja reiniciar o sistema? (s/n)"
read resposta
if [ resposta = "s" ]; then
    echo "## reiniciando..."
	sudo reboot
else
    echo "## ok. flw"
fi