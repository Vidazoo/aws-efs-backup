#!/usr/bin/env bash

# mount the drive
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 $EFS_ID.efs.us-east-1.amazonaws.com:/ /efs

# create a compressed version
cd /var/tmp
tar -zcvf /var/tmp/efs-`date +"%Y%m%d"`.tar.gz /efs

# copy everything to s3
aws s3 cp  /var/tmp/efs-`date +"%Y%m%d"`.tar.gz 3://vidazoo-backups/efs/efs-`date +"%Y%m%d"`.tar.gz