# Replicate folders to one or more servers each time you login
Setup your box to replicate any folder to one or more remote hosts for easy backup using rsync

## Deployment
To setup the configuration file for this script, execute gather_config_data.sh. Input the servers
you wish to replicate to, the folder you wish to backup, and the remote host destination.
Please ensure you have the correct previlages to gain access to the remote box and also sufficient 
privilages to write to whatever folder you wish to backup to.

And thats it! Every time you login, your folder will be synced with the server(s) you specified.

Also, there is a log file in the same folder as the script. If there are any problems check this.
Also, do not delete the files, as your bashrc will reference them. 
Also, you can add additional servers manually to the settings file after executing gather_config.data.sh
