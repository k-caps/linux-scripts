#!/bin/bash

# Usage:
# All objects in <dbname> will be transferred to <user_name>
# chmod +x ch_ownership.s && sh ch_ownership.sh -d dbname -user_name

# Vars:
WD=~/pg_change_ownership
mkdir -p $WD
SQLFILE=$WD/query_generator.sql
DMLFILE=$WD/dmlcommands.sql
DB_NAME=''
USER_NAME=''
while getopts "d:u:" arg; do
        case $arg in 
                d) DB_NAME="${OPTARG}";;
                u) USER_NAME="${OPTARGE}";;
        esac
done

# If you'd rather hardcode/ set the variables infile, do it here:
#DB_NAME=<value>
#USER_NAME=<value>
