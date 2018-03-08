#!/bin/bash

# PURPOSE
# This script servers for restoring custom values of attributes in
# template files for various device types in
# /opt/unetlab/html/templates.

# The tests can be run as a regular user.
# Run this script as 'sudo' to be able to modify templates in
# /opt/unetlab/html/templates

# BE ADVISED! PREPARE FOR SYNTACTIC SUGAR ;)

# BE ADVISED! DON'T EDIT THE TEMPLATES MANUALLY in
# /opt/unetlab/html/templates (only if you REALLY know, 
# what you're doing!). For that purpose, use this script instead!

# If something breaks, the original templates can be found here:
# https://gitlab.com/eve-ng-dev/eve-ng-public/tree/master/html/templates

# Replaces searched string ($1) with another string ($2) in a file ($3)
replace () {
  SEARCH_FOR_WORD=$1
  REPLACE_IT_WITH=$2
  IN_FILE=$3

  sed -i.bak "s/$SEARCH_FOR_WORD/$REPLACE_IT_WITH/" $IN_FILE
}


# Changes existing IDLE PC value to another IDLE PC value ($1) [given 
# by the dynamips utility in a file ($2)

change_idlepc_value () {
  SEARCH_FOR_WORD=.*\'idlepc\'.*
  REPLACE_IT_WITH="\$p[\'idlepc\'] = \'$1\';"
  IN_FILE=$2

  # The function 'replace' MUST be called with arguments WITH QUOTES!,
  # beacuse the variable "REPLACE_IT_WITH" contanins spaces and special
  # characters, which distorts the argument when passing to the function.
  # When the argument is surrouned with quotes ("$argument"),
  # then it will be passwd to the function in its entirety.

  replace "$SEARCH_FOR_WORD" "$REPLACE_IT_WITH" "$IN_FILE"
} 

change_ram_in_MB () {
  SEARCH_FOR_WORD=.*\'ram\'.*
  REPLACE_IT_WITH="\$p[\'ram\'] = $1;"
  IN_FILE=$2
  replace "$SEARCH_FOR_WORD" "$REPLACE_IT_WITH" "$IN_FILE"
}

change_num_of_cpu_cores () {
  SEARCH_FOR_WORD=.*\'cpu\'.*
  REPLACE_IT_WITH="\$p[\'cpu\'] = $1;"
  IN_FILE=$2
  replace "$SEARCH_FOR_WORD" "$REPLACE_IT_WITH" "$IN_FILE"
}


# Change the remote access type to the devices
# Valid options (choose one of them): telnet/vnc/rdp

change_remote_access_type () {
  SEARCH_FOR_WORD=.*\'console\'.*
  REPLACE_IT_WITH="\$p[\'console\'] = \'$1\';"
  IN_FILE=$2
  replace "$SEARCH_FOR_WORD" "$REPLACE_IT_WITH" "$IN_FILE"
}


# List of supported cards for specific device type can be found 
# inside the particular template file in "/opt/unetlab/html/templates".
# under 'modules' attribute.
# Only if the template file contains 'slot' attributes, the supported card
# listed in the template file can be inserted in that slot.

insert_card_in_slot1 () {
  SEARCH_FOR_WORD=.*\'slot1\'.*
  REPLACE_IT_WITH="\$p[\'slot1\'] = \'$1\';"
  IN_FILE=$2
  replace "$SEARCH_FOR_WORD" "$REPLACE_IT_WITH" "$IN_FILE"
}

insert_card_in_slot2 () {
  SEARCH_FOR_WORD=.*\'slot2\'.*
  REPLACE_IT_WITH="\$p[\'slot2\'] = \'$1\';"
  IN_FILE=$2
  replace "$SEARCH_FOR_WORD" "$REPLACE_IT_WITH" "$IN_FILE"
}

insert_card_in_slot3 () {
  SEARCH_FOR_WORD=.*\'slot3\'.*
  REPLACE_IT_WITH="\$p[\'slot3\'] = \'$1\';"
  IN_FILE=$2
  replace "$SEARCH_FOR_WORD" "$REPLACE_IT_WITH" "$IN_FILE"
}

insert_card_in_slot4 () {
  SEARCH_FOR_WORD=.*\'slot4\'.*
  REPLACE_IT_WITH="\$p[\'slot4\'] = \'$1\';"
  IN_FILE=$2
  replace "$SEARCH_FOR_WORD" "$REPLACE_IT_WITH" "$IN_FILE"
}

insert_card_in_slot5 () {
  SEARCH_FOR_WORD=.*\'slot5\'.*
  REPLACE_IT_WITH="\$p[\'slot5\'] = \'$1\';"
  IN_FILE=$2
  replace "$SEARCH_FOR_WORD" "$REPLACE_IT_WITH" "$IN_FILE"
}

insert_card_in_slot6 () {
  SEARCH_FOR_WORD=.*\'slot6\'.*
  REPLACE_IT_WITH="\$p[\'slot6\'] = \'$1\';"
  IN_FILE=$2
  replace "$SEARCH_FOR_WORD" "$REPLACE_IT_WITH" "$IN_FILE"
}

change_num_ethernet_4port_cards () {
  SEARCH_FOR_WORD=.*\'ethernet\'.*
  REPLACE_IT_WITH="\$p[\'ethernet\'] = $1;"
  IN_FILE=$2
  replace "$SEARCH_FOR_WORD" "$REPLACE_IT_WITH" "$IN_FILE"
}

change_num_serial_4port_cards () {
  SEARCH_FOR_WORD=.*\'serial\'.*
  REPLACE_IT_WITH="\$p[\'serial\'] = $1;"
  IN_FILE=$2
  replace "$SEARCH_FOR_WORD" "$REPLACE_IT_WITH" "$IN_FILE"
}

change_num_ethernet_interfaces () {
  change_num_ethernet_4port_cards $1 $2
}

####################################
#    The script evolution :)
####################################
#sed -i.bak "s/.*idlepc.*/$p[\'idlepc\'] = \'0x11111112\';/" /home/andrej/sed_test.txt
#sed -i.bak "s/.*idlepc.*/$p[\'idlepc\'] = \'0x11111113\';/" $FILE
#sed -i.bak "s/.*idlepc.*/$REPLACE_IT_WITH/" $FILE
#sed -i.bak "s/$WHAT_TO_SEARCH_FOR/$REPLACE_IT_WITH/" $FILE
#replace ".*idlepc.*" "$p[\'idlepc\'] = \'0x11111118\';" "/home/andrej/sed_test.txt"
#change_idlepc_value 0x11111118 /home/andrej/sed_test.txt

###########################################
#             TEMPLATES
###########################################

update_templates () {

  TEMPLATES_DIR=/opt/unetlab/html/templates/

  A10_TEMPLATE=a10.php
  change_remote_access_type       vnc        $TEMPLATES_DIR$A10_TEMPLATE

  ALTEON_TEMPLATE=alteon.php
  change_remote_access_type       vnc        $TEMPLATES_DIR$ALTEON_TEMPLATE

  BIGIP_TEMPLATE=bigip.php
  change_remote_access_type       vnc        $TEMPLATES_DIR$BIGIP_TEMPLATE

  C1710_TEMPLATE=c1710.php
  change_ram_in_MB                256        $TEMPLATES_DIR$C1710_TEMPLATE
  change_idlepc_value             0x80618b54 $TEMPLATES_DIR$C1710_TEMPLATE

  C3725_TEMPLATE=c3725.php
  change_ram_in_MB                320        $TEMPLATES_DIR$C3725_TEMPLATE
  insert_card_in_slot1            NM-1FE-TX  $TEMPLATES_DIR$C3725_TEMPLATE
  insert_card_in_slot2            NM-16ESW   $TEMPLATES_DIR$C3725_TEMPLATE
  change_idlepc_value             0x60a800f0 $TEMPLATES_DIR$C3725_TEMPLATE

  C7200_TEMPLATE=c7200.php
  change_ram_in_MB                512        $TEMPLATES_DIR$C7200_TEMPLATE
  insert_card_in_slot1            PA-FE-TX   $TEMPLATES_DIR$C7200_TEMPLATE
  insert_card_in_slot2            PA-FE-TX   $TEMPLATES_DIR$C7200_TEMPLATE
  insert_card_in_slot3            PA-FE-TX   $TEMPLATES_DIR$C7200_TEMPLATE
  insert_card_in_slot4            PA-FE-TX   $TEMPLATES_DIR$C7200_TEMPLATE
  insert_card_in_slot5            PA-4E      $TEMPLATES_DIR$C7200_TEMPLATE
  insert_card_in_slot6            PA-8E      $TEMPLATES_DIR$C7200_TEMPLATE
  change_idlepc_value             0x60189234 $TEMPLATES_DIR$C7200_TEMPLATE

  CSRNG_TEMPLATE=csr1000vng.php
  change_ram_in_MB                5120       $TEMPLATES_DIR$CSRNG_TEMPLATE

  CSR_TEMPLATE=csr1000v.php
  change_ram_in_MB                4608       $TEMPLATES_DIR$CSR_TEMPLATE

  CUMULUS_TEMPLATE=cumulus.php
  change_ram_in_MB                512        $TEMPLATES_DIR$CUMULUS_TEMPLATE
  change_remote_access_type       telnet     $TEMPLATES_DIR$CUMULUS_TEMPLATE

  HPVSR_TEMPLATE=hpvsr.php
  change_ram_in_MB                1024       $TEMPLATES_DIR$HPVSR_TEMPLATE
  change_num_of_cpu_cores         1          $TEMPLATES_DIR$HPVSR_TEMPLATE

  IOL_TEMPLATE=iol.php
  change_ram_in_MB                512        $TEMPLATES_DIR$IOL_TEMPLATE
  change_num_ethernet_4port_cards 2          $TEMPLATES_DIR$IOL_TEMPLATE
  change_num_serial_4port_cards   2          $TEMPLATES_DIR$IOL_TEMPLATE
  
  NXOS9K_TEMPLATE=nxosv9k.php
  change_num_of_cpu_cores         1          $TEMPLATES_DIR$NXOS9K_TEMPLATE
  change_ram_in_MB                8192       $TEMPLATES_DIR$NXOS9K_TEMPLATE

  OSTINATO_TEMPLATE=ostinato.php
  change_ram_in_MB                384        $TEMPLATES_DIR$OSTINATO_TEMPLATE

  TIMOS_TEMPLATE=timos.php
  change_ram_in_MB                3072       $TEMPLATES_DIR$TIMOS_TEMPLATE

  TIMOSCPM_TEMPLATE=timoscpm.php
  change_ram_in_MB                3072       $TEMPLATES_DIR$TIMOSCPM_TEMPLATE

  TIMOSIOM_TEMPLATE=timosiom.php
  change_ram_in_MB                3072       $TEMPLATES_DIR$TIMOSIOM_TEMPLATE

  VIOS_TEMPLATE=vios.php
  change_num_ethernet_interfaces  15         $TEMPLATES_DIR$VIOS_TEMPLATE

  VIOSL2_TEMPLATE=viosl2.php
  change_ram_in_MB                512        $TEMPLATES_DIR$VIOSL2_TEMPLATE
  change_num_ethernet_interfaces  16         $TEMPLATES_DIR$VIOSL2_TEMPLATE

  VMX_TEMPLATE=vmx.php
  change_ram_in_MB                12288      $TEMPLATES_DIR$VMX_TEMPLATE

  VMXVCP_TEMPLATE=vmxvcp.php
  change_ram_in_MB                14336      $TEMPLATES_DIR$VMXVCP_TEMPLATE

  VMXVFP_TEMPLATE=vmxvfp.php
  change_ram_in_MB                6144       $TEMPLATES_DIR$VMXVFP_TEMPLATE

  VSRX_TEMPLATE=vsrx.php
  change_num_of_cpu_cores         1          $TEMPLATES_DIR$VSRX_TEMPLATE
  change_ram_in_MB                4096       $TEMPLATES_DIR$VSRX_TEMPLATE

  VSRXNG_TEMPLATE=vsrxng.php
  change_num_of_cpu_cores         1          $TEMPLATES_DIR$VSRXNG_TEMPLATE
  change_ram_in_MB                6144       $TEMPLATES_DIR$VSRXNG_TEMPLATE

  XRV9K_TEMPLATE=xrv9k.php
  change_num_of_cpu_cores         2          $TEMPLATES_DIR$XRV9K_TEMPLATE
  change_ram_in_MB                13312      $TEMPLATES_DIR$XRV9K_TEMPLATE

  XRV_TEMPLATE=xrv.php
  change_ram_in_MB                2048       $TEMPLATES_DIR$XRV_TEMPLATE

  PFSENSE_TEMPLATE=pfsense.php
  change_remote_access_type       vnc        $TEMPLATES_DIR$PFSENSE_TEMPLATE

  PRIME_INFRA_TEMPLATE=prime.php
  change_remote_access_type       telnet     $TEMPLATES_DIR$PRIME_INFRA_TEMPLATE

  VWAAS_TEMPLATE=vwaas.php
  change_remote_access_type       vnc        $TEMPLATES_DIR$VWAAS_TEMPLATE

}

###########################################
#             CHANGE TEMPLATES
#
#        after everything was tested
###########################################

update_templates
