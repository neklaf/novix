#!/bin/bash
. /home/novix/.bashrc
. ${H}/common/common.must-be-root
echo "Shutting down NOVIX and cleaning caches for a new release."
echo ""
echo ""
cd ${H}
echo "/var/log..."
rm -rf /var/log/*
echo "/tmp"
rm -rf /tmp/*
echo "cleaning up my kubernetes..."
novix.k8s-reset
echo "bash_history..."
shred /home/novix/.bash_history
shred /root/.bash_history
history -c
rm -rf .bash_history
rm -rf /root/.bash_history
echo "pacman cache..."
rm -rf /var/cache/pacman/pkg/*
echo ".config...."
rm -rf .config/*
echo ".kube..."
rm -rf .kube/*
echo "cleaning up my emacs..."
find . -name '*~' -exec rm {} \;
echo ""
cat /etc/novix/motd.banner
sleep 1
shutdown now
