#!/bin/bash
### Install packages
yum clean all; rm -rf /var/cache/yum/*;
yum -y install vim-enhanced ipa-client ncdu htop iftop iotop cockpit bash-completion mlocate 

### IPA
ipa-client-install --mkhomedir

### Backup Script
mkdir /var/lib/ovirt-engine-backups/

cat > /usr/bin/backup.sh <<EOF
#!/bin/bash
##  This is a script for baqcking up the HostedEngine
echo -e "\n\n#######  Starting HostedEngine backup now  #######" >> /var/log/ovirt-engine-backups.log
/usr/bin/engine-backup --mode=backup --scope=all --file="/var/lib/ovirt-engine-backups/engine-backup-$(date +%Y-%m-%d_%H-%M).tar.bz2" --log=/var/log/ovirt-engine-backups.log
echo -e "#######  HostedEngine backup has finished  #######\n\n" >> /var/log/ovirt-engine-backups.log
## Cleanup old backups
find /var/lib/ovirt-engine-backups/ -type f -name "*.tar.bz2" -mtime 31 -exec rm {} \;
EOF

chmod +x /usr/bin/backup.sh

### Crontab
vim /etc/crontab
echo '30 3 * * * root /usr/bin/backup.sh >/dev/null 2>&1' >> /etc/crontab

### Logrotate
cd /etc/logrotate.d/
vim ovirt-engine
vim ovirt-engine-backups

cat > ovirt-engine-backups <<EOF
/var/log/ovirt-engine-backups.log {
    compress
    rotate 8
    size 10M
}
EOF
