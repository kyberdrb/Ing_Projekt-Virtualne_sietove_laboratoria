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

####################################
#    The script evolution :)
####################################
#sed -i.bak "s/.*idlepc.*/$p[\'idlepc\'] = \'0x11111112\';/" /home/andrej/sed_test.txt
#sed -i.bak "s/.*idlepc.*/$p[\'idlepc\'] = \'0x11111113\';/" $FILE
#sed -i.bak "s/.*idlepc.*/$REPLACE_IT_WITH/" $FILE
#sed -i.bak "s/$WHAT_TO_SEARCH_FOR/$REPLACE_IT_WITH/" $FILE
#replace ".*idlepc.*" "$p[\'idlepc\'] = \'0x11111118\';" "/home/andrej/sed_test.txt"
#change_idlepc_value 0x11111118 /home/andrej/sed_test.txt

##################
#     TESTS
##################

run_tests () {
  #Setup
  TEMPLATE_C1710=/opt/unetlab/html/templates/c1710.php
  TEMPLATE_ASAV=/opt/unetlab/html/templates/asav.php
  TEMPLATE_C7200=/opt/unetlab/html/templates/c7200.php
  TEMPLATE_IOL=/opt/unetlab/html/templates/iol.php
  
  SED_TEST_C1710=$HOME/sed_test_1.txt
  SED_TEST_2_ASAV=$HOME/sed_test_2.txt
  SED_TEST_3_C7200=$HOME/sed_test_3.txt
  SED_TEST_4_IOL=$HOME/sed_test_4.txt

  cat $TEMPLATE_C1710 > $SED_TEST_C1710
  cat $TEMPLATE_ASAV > $SED_TEST_2_ASAV
  cat $TEMPLATE_C7200 > $SED_TEST_3_C7200
  cat $TEMPLATE_IOL > $SED_TEST_4_IOL

  # Testing methods
  #replace ".*idlepc.*" "$p[\'idlepc\'] = \'0x11111118\';" "$SED_TEST_C1710"

  change_idlepc_value 0x11111111 $SED_TEST_C1710
  change_ram_in_MB 222 $SED_TEST_C1710

  change_num_of_cpu_cores 3 $SED_TEST_2_ASAV
  change_remote_access_type vnc $SED_TEST_2_ASAV

  insert_card_in_slot1 PA-FE-TX $SED_TEST_3_C7200
  insert_card_in_slot2 PA-FE-TX $SED_TEST_3_C7200
  insert_card_in_slot3 PA-FE-TX $SED_TEST_3_C7200
  insert_card_in_slot4 PA-FE-TX $SED_TEST_3_C7200
  insert_card_in_slot5 PA-4E $SED_TEST_3_C7200
  insert_card_in_slot6 PA-8E $SED_TEST_3_C7200

  change_num_serial_4port_cards 1 $SED_TEST_4_IOL

  ##############
  # COMPARISONS
  ##############
  echo "#############################################################"
  echo "c1710: Original vs Edited"
  diff $TEMPLATE_C1710 $SED_TEST_C1710

  echo
  echo "#############################################################"
  echo "ASAv: Original vs Edited"
  diff $TEMPLATE_ASAV $SED_TEST_2_ASAV

  echo
  echo "#############################################################"
  echo "c7200: Original vs Edited"
  diff $TEMPLATE_C7200 $SED_TEST_3_C7200

  echo
  echo "#############################################################"
  echo "IOL: Original vs Edited"
  diff $TEMPLATE_IOL $SED_TEST_4_IOL
}

###########################################
#             TEMPLATES
###########################################

update_templates () {

  TEMPLATES_DIR=/opt/unetlab/html/templates/

  IOL_TEMPLATE=iol.php
  change_ram_in_MB                240  $TEMPLATES_DIR$IOL_TEMPLATE
  change_num_ethernet_4port_cards 2    $TEMPLATES_DIR$IOL_TEMPLATE
  change_num_serial_4port_cards   2    $TEMPLATES_DIR$IOL_TEMPLATE

  C1710_TEMPLATE=c1710.php
  change_idlepc_value  0x80618b54 $TEMPLATES_DIR$C1710_TEMPLATE

  C3725_TEMPLATE=c3725.php
  insert_card_in_slot1 NM-16ESW  $TEMPLATES_DIR$C3725_TEMPLATE
  change_idlepc_value  0x60a800f0 $TEMPLATES_DIR$C3725_TEMPLATE

  C7200_TEMPLATE=c7200.php
  change_ram_in_MB     240        $TEMPLATES_DIR$C7200_TEMPLATE
  insert_card_in_slot1 PA-8E      $TEMPLATES_DIR$C7200_TEMPLATE
  change_idlepc_value  0x60189234 $TEMPLATES_DIR$C7200_TEMPLATE

   
}

###########################################
#           RUN ALL THE TESTS
#
#       after making some changes
###########################################

#run_tests

###########################################
#             CHANGE TEMPLATES
#
#        after everything was tested
###########################################

update_templates