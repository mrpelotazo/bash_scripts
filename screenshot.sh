###############################################################################
# Name        : screenshot.sh
# Description : Take a screenshot using scrot and Xdialog. Will prompt for
#               a full screen capture or select a window/area.
# Date        : 15.06.2013
# Author      : Adrian Antonana <a.antonana@gmail.com>
###############################################################################


#!/bin/bash

# check xdialog is present
checkXdialog() {
	DIALOG="$(which Xdialog 2> /dev/null)"
	[[ $? != 0 ]] && exit 1
	DIALOG+=" --stdout"
}

# check scrot is present
checkScrot() {
	SCROT="$(which scrot 2> /dev/null)"
	[[ $? != 0 ]] && exit 1
}

# ask for full screen or area
getMode() {
	MODE="$($DIALOG --title "Screen Capture" --radiolist "Select mode" 10 60 0 fullscreen "Take a full screen capture" on area "Select a window or area to capture" off)"
}

# main part
checkXdialog
checkScrot
getMode

case "$MODE" in
	"fullscreen")
					$SCROT '%Y-%m-%d_%s_$wx$h.png' -e 'mv $f ~'
					;;
	"area")
					$SCROT -s '%Y-%m-%d_%s_$wx$h.png' -e 'mv $f ~'
					;;
	*)
					echo "error"
					;;
esac

exit 0
