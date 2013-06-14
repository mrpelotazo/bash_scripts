#!/bin/bash



# constants
FONT='-*-fixed-*-*-*-*-100-*-*-*-*-*-*-*'
COLOR="green"
DELAY=4
POS="bottom"
ALIGN="center"
BARMOD="percentage"
VOLTXT="Volume"
VOLMUTEDTXT="Muted"
VOLSTEP=2



# kills an existing osd_cat process
# needed when holding down a key to force repaint of the onscreen message
preKill() {
	killall osd_cat
}

# gets the actual volume value
getVol() {
	VOL="$(amixer sget Master | grep "Mono:" | awk '{ print $4 }' | sed -e 's/\[//' -e 's/\]//' -e 's/\%//')"
}

# gets the actual volume value and prints is on the screen
# with a percent bar + a percent number
showVol() {
	getVol
	if [[ $VOL == 0 ]]; then
		osd_cat --pos="$POS" --align="$ALIGN" --delay="$DELAY" --colour="$COLOR" --font="$FONT" --barmode="$BARMOD" --text="$VOLMUTEDTXT $VOL%" --percentage="$VOL"
	else
		osd_cat --pos="$POS" --align="$ALIGN" --delay="$DELAY" --colour="$COLOR" --font="$FONT" --barmode="$BARMOD" --text="$VOLTXT $VOL%" --percentage="$VOL"
	fi
}

# reises the master channel by "VOLSTEP"
volUp() {
	amixer sset Master "$VOLSTEP+"
}

# decreases the master channel by "VOLSTEP"
volDown() {
	amixer sset Master "$VOLSTEP-"
}

# mutes the master channel
volMute() {
	amixer sset Master 0
}


# main part
preKill

case "$1" in
	"volup")
			volUp
			showVol
			;;
	"voldown")
			volDown
			showVol
			;;
	"mute")
			volMute
			showVol
			;;
	*)
			;;
esac
