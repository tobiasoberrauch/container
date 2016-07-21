#!/usr/bin/env bash

#
# http://jbrazile.blogspot.com.es/2012/01/scripted-vmdkova-images-wboxgrinder-and.html
#

NAME=$1
OS=$2
IMAGE=
SZMB=384
INSTDIR=/tmp/ova-gen/boxes
BUILDDIR=/tmp/ova-gen/builds

if [ -z "$NAME" ]; then
  echo "Usage: ova-gen.sh <appliance-name> [ostype]"
  exit 1
fi

if [ -z "$OS" ]; then
  OS=Linux26_64
  echo Setting OS type to $OS
fi

rm -rf ${INSTDIR} ${BUILDDIR}
mkdir -p ${BUILDDIR} ${INSTDIR}

if [ ! -d "build/appliances" ]; then
    echo "Invalid directory. Running from Boxgrinder template build dir?"
    exit 1
fi

for vmdk in `find build/appliances/ -name '*.vmdk'`; do
  echo Copying $vmdk to $INSTDIR
  cp $vmdk $INSTDIR
  IMAGE="$INSTDIR/`basename $vmdk`"
  echo "IMAGE: $IMAGE"
done

VBoxManage createvm --name ${NAME} --ostype ${OS} --register --basefolder ${INSTDIR}
VBoxManage modifyvm ${NAME} --memory ${SZMB} --vram 32
VBoxManage storagectl ${NAME} --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach ${NAME} --storagectl "SATA Controller" --type hdd --port 0 --device 0 --medium ${IMAGE}
VBoxManage export ${NAME} --manifest -o ${BUILDDIR}/${NAME}.ova
VBoxManage unregistervm ${NAME} --delete
echo "Your appliance is ready at ${BUILDDIR}/${NAME}.ova"
# VirtualBox --startvm ${NAME}