#!/bin/bash

echo "Writte DataBase user: "
read USER

echo "Writte DataBase passwd: "
read PASSWD

CHARSET=utf8

BACKUP_PATH=/home

DBNAME=newdata

HOST=127.0.0.1

PROJNAME=PerlConfigs

PROG_PATH=/root/

PREFIX=`date +%F`

echo "$PREFIX"

echo "$DATABASE_NAME";





#start backup 

echo "[--------------------------------[`date +%F--%H-%M`]--------------------------------]"
echo "[----------][`date +%F--%H-%M`] Run the backup script..."
mkdir $BACKUP_PATH/$PREFIX
echo "[++--------][`date +%F--%H-%M`] Generate a database backup..."

mysqldump --user=$USER --host=$HOST --password=$PASSWD  --default-character-set=$CHARSET $DBNAME > $BACKUP_PATH/$PREFIX/$DBNAME-`date +%F--%H-%M`.sql

if [[ $? -gt 0 ]];then #here we check status of last command  -dt mean "more"
echo "[++--------][`date +%F--%H-%M`] Aborted. Generate database backup failed."
exit 1  #exit 1 mean that program have finished with error, but it was not fatal
fi

echo "[++++------][`date +%F--%H-%M`] Backup database [$DBNAME] - successfull."

echo "[++++++++--][`date +%F--%H-%M`] Copy the source code project [$PROJNAME] successfull."

tar -cpzf  $BACKUP_PATH/$PREFIX.tar.gz $BACKUP_PATH/$PREFIX 

if [[ $? -gt 0 ]];then
echo "[++++++----][`date +%F--%H-%M`] Aborted. compressing was failed!."
exit 1
fi

echo "[++++++++--][`date +%F--%H-%M`] compressing successfull!"

echo "[++++++++++][`date +%F--%H-%M`] All operations completed successfully!"
exit 0

