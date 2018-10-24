#!/bin/bash
#title		: Gather configuration data for back up
#description	: Help the user generate a configuration file for backing up a directory
#author		: Martin Kennelly
#date		: 23/10/18
#bash version	: 4.4-release

declare -a servers
finished=0

while [ ${finished} -eq 0 ]
do
  echo -e "Enter user and server you wish to back up to using the format [user]@[ip||FQDN] OR Enter to finish inputting servers to replicate to:"
  read input
  if [[ $input = "q" ]] || [ -z ${input} ]; 
  then
    finished=1
  else
    servers=("${servers[@]}" ${input})
  fi
done

if [ ${#servers[@]} -ne 0 ]
then
  echo -e "Enter where you wish to save your backups remotely\nor enter nothing for default (/var/tmp/$(uname -n)):"
  read input
  if [ -z ${input+z} ] || [ -z ${input} ];
  then
    default_remote_loc="/var/tmp/$(uname -n)"
  else
    default_remote_loc=${input}
  fi
 
  echo -e "Enter the local dir you wish to backup\nor enter nothing for default (/home/$(whoami)):"
  read input
  if [ -z ${input+z} ] || [ -z ${input} ];
  then
    default_local_loc="/home/$(whoami)"
  else
    default_local_loc=${input}
  fi

  servers_str=""
  for server in ${servers[@]}
  do
    servers_str="${servers_str}\"$server\" "
  done
  echo "#### Created configuration file for backup ####"
  echo -e "#!/bin/bash\nservers_to_replicate_to=( ${servers_str})\nremote_backup_dir=${default_remote_loc}\nhost_dir_to_backup=${default_local_loc}" > $(pwd)/backup_settings.sh
  echo "#### Added Backup to bashrc file ####"
  echo -e "if [ -f $(pwd)/run_backup.sh ]; then\n  . $(pwd)/run_backup.sh\nfi" >> ~/.bashrc
  echo "#### Done ####"
fi
