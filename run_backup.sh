#!/bin/bash
#title		: Backup of directory to one or more servers
#description	: A user can configure the back_settings.sh file to pick which directory to 
#		  capture, by default its the current users home directory. A user, must
#		  also specify the remote directory to place the backup in. The default is
#		  /var/tmp/[hostname]
#author		: Martin Kennelly
#version	: 0.1
#bash_version	: 4.4-release

timestamp=$( date +%Y-%m-%d_%H-%M-%S )
echo "########## Starting backup - $timestamp ##########" >> $(pwd)/backup.log

#Check if settings file exists, and load conf data
if [ -r $(pwd)/backup_settings.sh ]; then
  source $(pwd)/backup_settings.sh
else
  echo "${timestamp} : Could not find or read backup.conf file. Quitting" >> $(pwd)/backup.log
  exit 1
fi

# Ensure at least one server to replicate to is defined
if [ ${#servers_to_replicate_to[@]} -eq 0 ]; then
  echo "${timestamp} : Please enter servers in the backup.conf for which to replicate your backup to"
  exit 1
fi

# Iterate though the servers that we wish to replicate to and rsync
for user_server in "${servers_to_replicate_to[@]}"
do
  rsync -r -a -e ssh --delete $host_dir_to_backup $user_server:$remote_backup_dir &>> $(pwd)/backup.log
done

