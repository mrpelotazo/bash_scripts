#/bin/bash

#########################################################################################
#
# Name        : irc.sh
# Date        : 24.08.2013
# Author      : Adrian Antonana <a.antonana@gmail.com>
# Description : This script opens a ssh session on the remote host which runs a znc bouncer
#               and starts irssi.
#               This way there is no need to have an open port for the znc bouncer. Irssi
#               connects to znc localy on the remote host after the ssh session is established
#               and traffic between remote host and machine running this script moves through
#               an encrypted connection.
#
#########################################################################################

if [[ $# != 1 ]]; then
	echo "ERROR: Wrong parameter number."
	exit 1
fi

terminator --geometry=800x600+800+300 -b -T IRC -x ssh "$1" -t irssi &

exit 0
