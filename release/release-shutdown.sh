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
echo "cleaning up your kubernetes..."
novix.k8s-reset
echo "cleaning up your docker..."
docker rmi $(docker images -q)
docker rm -vf $(docker ps -aq)
docker rmi -f $(docker images -aq)
docker volume prune -f
docker system prune -a -f
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
echo "cleaning up your emacs..."
find . -name '*~' -exec rm {} \;
echo ""
cat /etc/novix/motd.banner
sleep 1
shutdown now
