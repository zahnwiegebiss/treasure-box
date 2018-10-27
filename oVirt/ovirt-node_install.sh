#!/bin/bash
### Bascic configurations
saslpasswd2 -a libvirt tusz

postconf -e mailbox_size_limit=512000000
systemctl reload postfix

### IPA
ipa-client-install --mkhomedir

### Install packages
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
vi /etc/yum.repos.d/epel.repo # disable epel

yum install -y cockpit-ovirt-dashboard.noarch cockpit-machines-ovirt bash-completion mlocate deltarpm vim-minimal strace sg3_utils
yum install -y --enablerepo epel vim-enhanced bash-completion iotop iftop ncdu htop

### Update system
yum clean all; rm -rf /var/cache/yum/*; yum update

### Copy packages to HE
yum --downloadonly reinstall --enablerepo epel htop iftop iotop ncdu
scp /var/cache/yum/x86_64/7/epel/packages/[htop,iftop,ncdu]* root@kvm-ohe201:~/
