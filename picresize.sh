#!/bin/bash


# paths, constants, etc.
PICPATH="$1"
TOTALPICS="$((($# - 1)))"
STEP="$(((100 / $TOTALPICS)))"
PROGR=0
MINSIZE=1
MAXSIZE=500

# get the new size percentage, check it and set output directory path
SIZE=""
while [ -z "$SIZE" ] || [[ $SIZE<$MINSIZE ]] || [[ $SIZE>$MAXSIZE ]]; do
	SIZE="$(zenity --entry --title="Picture Resize" --text="Enter percentage...")"

	# exit if cancel pressed
	[[ $? != 0 ]] && exit 0

	# check range
	if [[ $SIZE<$MINSIZE ]] || [[ $SIZE>$MAXSIZE ]]; then
		zenity --error --text="$SIZE% is outside the accepted range: 1% - 500%!"
	fi
done

OUTPATH="resize_$SIZE%"

# check if output directory exists
[ -d "$PICPATH/$OUTPATH" ] || mkdir "$PICPATH/$OUTPATH"
shift

# convert pics, show progress bar
while (( $# )); do
	convert "$PICPATH/$1" -resize "$SIZE%" "$PICPATH/$OUTPATH/resized_$SIZE%-$1"
	((PROGR+=$STEP))
	echo $PROGR
	shift
done | zenity --progress --title="Picture Resize" --text="working..." --percentage=0 --auto-close

# check return value and print message depending on it
[[ $? == 0 ]] && zenity --info --title="Picture Resize" --text="All done!" || zenity --error --text="Canceled!"
