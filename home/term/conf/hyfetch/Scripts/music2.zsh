#!/usr/bin/env zsh

yellow=$(tput setaf 11)
magenta=$(tput setaf 13)
white=$(tput setaf 15)

rawPlayer=$(playerctl --list-all | grep -v 'firefox' | head -1)

rawPosition=$(playerctl --player $rawPlayer position)

position=$(echo $rawPosition | sed 's/\..*//')
positionSeconds=$(($position % 60))
positionMinutes=$(($position / 60))

rawLength=$(playerctl --player $rawPlayer metadata mpris:length)

scaledLength=$(($rawLength / 1000000))
lengthSeconds=$(($scaledLength % 60))
lengthMinutes=$(($scaledLength / 60))

rawProgress=$(($position * 10 / $scaledLength))
progress="$white"
for ((i=0; i<$rawProgress; i++)); do
	progress+="-"
done
progress+="$magenta●$white"
for ((i=9; i>$rawProgress; i--)); do
	progress+="-"
done

printf "$yellow$positionMinutes$white:$yellow%02d $progress $yellow$lengthMinutes$white:$yellow%02d" $positionSeconds $lengthSeconds
