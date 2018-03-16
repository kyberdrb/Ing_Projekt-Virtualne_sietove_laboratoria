#!/bin/bash

# This is a script for backing up files on EVE-ng and GNS3 server
# The same script can be used on both platforms without change.

# Pass PATH variable with path to this script for cron job
# Add script directory to the beginning of the PATH variable (in my case, the script is located in '/home/andrej/')

PATH=/home/andrej:/home/andrej/bin:/home/andrej/.local/bin:/home/andrej/bin:/home/andrej/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

##############################################################################
#
# DON'T FORGET TO CHANGE THE "REMOTE_IP" variable to <IP_ADDRESS_OF_REMOTE_SERVER> 
# and MYSQL_PASSWD to "<MYSQL_PASSWORD>"!
#
REMOTE_IP=<IP_ADDRESS_OF_REMOTE_SERVER> 
MYSQL_PASSWD="<MYSQL_PASSWORD>"
##############################################################################

REMOTE_USER=andrej
REMOTE_MAIN_BACKUP_DIR=/home/$REMOTE_USER/zalohy_virtualnych_sietovych_laboratorii
SSH_KEY_FILE=$HOME/.ssh/id_rsa

EVE_NG_DB_LOCAL_BACKUP=$HOME/eve_ng_db.sql
GUACDB_LOCAL_BACKUP=$HOME/guacdb.sql
ALL_DB_LOCAL_BACKUP=$HOME/vsetky_mysql_databazy.sql

MAIN_EVE_NG_DIR=/opt/unetlab
MAIN_GNS3_DIR=/opt/gns3

##########################################
#                 METHODS
#
# methods reflect the directory structure
##########################################

#synchronize () {
backup () {
  LOCAL_FILE_OR_DIR=$1
  REMOTE_DIR=$2
  
  rsync -a -e "ssh -i $SSH_KEY_FILE" \
    --rsync-path="mkdir -p $REMOTE_DIR && rsync" \
    $LOCAL_FILE_OR_DIR \
    $REMOTE_USER@$REMOTE_IP:$REMOTE_DIR
}

backup_shared_resources () {

  backup $HOME \
    $REMOTE_MAIN_BACKUP_DIR/shared_resources/HOME/

  if [ -d "$MAIN_EVE_NG_DIR" ] && [ -d "$MAIN_GNS3_DIR" ]; then
    echo  "If you are able to have EVE-ng and GNS3 on the same server, \
          then you also are able to edit this script to decide, which directory \
          contains all images!"
    exit 1
  fi

  if [ -d "$MAIN_EVE_NG_DIR" ]; then

    backup $MAIN_EVE_NG_DIR/addons/dynamips/ \
      $REMOTE_MAIN_BACKUP_DIR/shared_resources/images/opt_unetlab_addons_dynamips_-_opt_gns3_images_IOS

    backup $MAIN_EVE_NG_DIR/addons/iol/bin/ \
      $REMOTE_MAIN_BACKUP_DIR/shared_resources/images/opt_unetlab_addons_iol_bin_-_opt_gns3_images_IOU

    backup $MAIN_EVE_NG_DIR/addons/qemu/ \
      $REMOTE_MAIN_BACKUP_DIR/shared_resources/images/opt_unetlab_addons_qemu_-_opt_gns3_images_QEMU

    backup $MAIN_EVE_NG_DIR/addons/rozne_zariadenia/ \
      $REMOTE_MAIN_BACKUP_DIR/shared_resources/images/opt_unetlab_addons_rozne_zariadenia_-_opt_gns3_images_rozne_zariadenia

  fi

  if [ -d "$MAIN_GNS3_DIR" ]; then

    backup $MAIN_GNS3_DIR/images/IOS/ \
      $REMOTE_MAIN_BACKUP_DIR/shared_resources/images/opt_unetlab_addons_dynamips_-_opt_gns3_images_IOS

    backup $MAIN_GNS3_DIR/images/IOU/ \
      $REMOTE_MAIN_BACKUP_DIR/shared_resources/images/opt_unetlab_addons_iol_bin_-_opt_gns3_images_IOU

    #pri QEMU zariadeniach budu duplicity, ale no a co - ulozneho priestoru je dostatok
    backup $MAIN_GNS3_DIR/images/QEMU/ \
      $REMOTE_MAIN_BACKUP_DIR/shared_resources/images/opt_unetlab_addons_qemu_-_opt_gns3_images_QEMU

    backup backup $MAIN_GNS3_DIR/images/rozne_zariadenia/ \
      $REMOTE_MAIN_BACKUP_DIR/shared_resources/images/opt_unetlab_addons_rozne_zariadenia_-_opt_gns3_images_rozne_zariadenia

  fi
}

backup_eve_ng_specific_files () {

  mysqldump --user='root' --password="$MYSQL_PASSWD" eve_ng_db -r $EVE_NG_DB_LOCAL_BACKUP
  mysqldump --user='root' --password="$MYSQL_PASSWD" guacdb    -r $GUACDB_LOCAL_BACKUP
  mysqldump --user='root' --password="$MYSQL_PASSWD" --all-databases -r $ALL_DB_LOCAL_BACKUP

  backup $EVE_NG_DB_LOCAL_BACKUP \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/var_lib_mysql

  backup $GUACDB_LOCAL_BACKUP \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/var_lib_mysql

  backup $ALL_DB_LOCAL_BACKUP \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/var_lib_mysql

  rm $EVE_NG_DB_LOCAL_BACKUP
  rm $GUACDB_LOCAL_BACKUP
  rm $ALL_DB_LOCAL_BACKUP

  backup $MAIN_EVE_NG_DIR/html/templates \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/opt_unetlab_html_templates

  backup $MAIN_EVE_NG_DIR/labs/ \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/opt_unetlab_labs

  backup /etc/hostname \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/etc/

  backup /etc/ssh/sshd_config \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/etc_ssh/

  backup /etc/issue.net \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/etc/

  backup /etc/motd \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/etc/

  backup /etc/network/interfaces \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/etc_network/

  backup /etc/apache2/apache2.conf \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/etc_apache2_conf/

  backup /etc/apache2/sites-enabled/unetlab.conf \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/etc_apache2_sites_enabled/

  backup /etc/apache2/sites-enabled/default-ssl.conf \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/etc_apache2_sites_enabled/

  backup /usr/bin/dstat_custom \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/usr_bin/

  backup /var/lib/lxc/eve-ng-lxc/config \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/var_lib_lxc_eve-ng-lxc

  backup /opt/unetlab/wrappers/unl_wrapper \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/opt_unetlab_wrappers/

  backup /opt/unetlab/html/api.php \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/opt_unetlab_html/

  backup /opt/unetlab/html/includes/api_uusers.php \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/opt_unetlab_html_includes/

  backup /opt/unetlab/html/includes/functions.php \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/opt_unetlab_html_includes/

  backup /opt/unetlab/html/themes/default/index.html \
    $REMOTE_MAIN_BACKUP_DIR/eve_ng_specific/opt_unetlab_html_themes_default/
}

backup_gns3_specific_files () {

  backup /home/gns3/gns3-server/gns3server/appliances \
    $REMOTE_MAIN_BACKUP_DIR/gns3_specific/home_gns3_gns3-server_gns3server_appliances

  backup /opt/gns3/projects/ \
    $REMOTE_MAIN_BACKUP_DIR/gns3_specific/opt_gns3_projects
}


##########
#  MAIN
##########

backup_shared_resources

if [ -d "$MAIN_EVE_NG_DIR" ]; then
  backup_eve_ng_specific_files
fi

if [ -d "$MAIN_GNS3_DIR" ]; then
  backup_gns3_specific_files
fi

