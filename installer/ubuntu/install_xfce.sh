
service="[Unit]
Description=Start TigerVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
User=root
Group=root
WorkingDirectory=/root

PIDFile=/root/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -geometry 1920x1056 -localhost no :%i
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target"

xstartup="#!/bin/sh

xrdb \$HOME/.Xresources
xsetroot -solid grey
export XKL_XMODMAP_DISABLE=1
/etc/X11/Xsession
startxfce4 &"

sudo apt-get install xfce4-session xfce4-goodies -y 

echo $service | sudo tee /etc/systemd/system/vncserver@.service
sudo vncserver -passwd

echo $xstartup | sudo tee $HOME/.vnc/xstartup
sudo chmod 755 $HOME/.vnc/xstartup

