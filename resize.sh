#!/usr/bin/env bash

source=$1;
size=$2;
if [[ ${source} == *".vmdk" ]]
then
    target="${source/vmdk/vdi}";

    echo ${source};
    echo ${target};
    echo ${size};
#
#        VBoxManage clonehd source target --format vdi
#        VBoxManage modifyhd target --resize $2
#        VBoxManage clonehd target source --format vmdk

# download parted magic

#lvextend -l +100%FREE /dev/mapper/packer--virtualbox--iso--1422588891-root
#resize2fs -p /dev/mapper/packer--virtualbox--iso--1422588891-root
fi
