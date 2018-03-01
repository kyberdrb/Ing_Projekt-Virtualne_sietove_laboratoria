#!/bin/bash

OUTPUT_CSV_FILE=$1

dstat -T -c -C total,0,1,2,3,4,5,6,7 -m -d -D sda --disk-util --disk-tps --output ~/$OUTPUT_CSV_FILE.csv