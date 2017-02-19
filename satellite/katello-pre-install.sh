#!/bin/bash
#######################################################################
#
#  Prepare system for installing katello
#
#######################################################################

echo
echo "*******  install deltarpm mlocate tree"
yum install deltarpm mlocate tree

echo
echo "*******  install repos for katello"
yum -y localinstall http://fedorapeople.org/groups/katello/releases/yum/3.2/katello/el7/x86_64/katello-repos-latest.rpm
yum -y localinstall http://yum.theforeman.org/releases/1.13/el7/x86_64/foreman-release.rpm
yum -y localinstall https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y localinstall http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install foreman-release-scl

echo
echo "*******  update system"
yum clean all
yum update

echo
echo "*******  install katello"
yum install katello foreman-libvirt foreman-ovirt foreman-vmware

echo
echo "*******  preparation complete. PLEASE REBOOT!"
