#!/bin/bash
# Script to import devices from EVE-ng to GNS3

EVE_NG_QEMU_FILE_STRUCTURE=$1

GNS3_QEMU_IMAGES_DIR=/opt/gns3/images/QEMU/
mkdir -p $GNS3_QEMU_IMAGES_DIR

DIR=${EVE_NG_QEMU_FILE_STRUCTURE%/}
mv $DIR/vmxvfp* $GNS3_QEMU_IMAGES_DIR > /dev/null 2>&1

for i in $(find $EVE_NG_QEMU_FILE_STRUCTURE -maxdepth 1 -type d)
do
 
  echo $i

  if [ $i == $EVE_NG_QEMU_FILE_STRUCTURE ]; then
    echo "Skipping recursive restoration of entire backup QEMU folder to GNS3 QEMU folder. Only subdirectories are needed."
    echo
    continue
  fi

  NUM_OF_FILES=$(ls -l $i | egrep -c '^-.*qcow2')
  if [ $NUM_OF_FILES -ne 1 ]; then
    echo "This directory has either 0 or more than 1 QCOW2 file. Moving it to GNS3 QEMU directory..."
    mv $i $GNS3_QEMU_IMAGES_DIR
    echo
    sleep 2
    continue
  fi

  IMAGE_NAME=$(echo "$i" | cut -d'/' -f6)
  GNS3_QEMU_IMAGES_DIR=${GNS3_QEMU_IMAGES_DIR%/}

  mv $i/hda.qcow2 $GNS3_QEMU_IMAGES_DIR/$IMAGE_NAME.qcow2 > /dev/null 2>&1
  mv $i/virtioa.qcow2 $GNS3_QEMU_IMAGES_DIR/$IMAGE_NAME.qcow2 > /dev/null 2>&1
  mv $i/sataa.qcow2 $GNS3_QEMU_IMAGES_DIR/$IMAGE_NAME.qcow2 > /dev/null 2>&1

  echo
  sleep 2
done

ls -l $GNS3_QEMU_IMAGES_DIR

