#!/usr/bin/env zsh

red=$(tput setaf 9)
green=$(tput setaf 10)
yellow=$(tput setaf 11)
white=$(tput setaf 15)

rawPlayer=$(playerctl --list-all | grep -v 'firefox' | head -1)

rawVolume=$(playerctl --player $rawPlayer volume)
longVolume=$(echo $rawVolume | sed 's/0*\.//')
shortVolume=$(($longVolume / 100000))

volume="Volume: "
for ((i=0; i<$shortVolume; i++)); do
	if ((i == 0)); then
		volume+=$green
	elif ((i == 6)); then
		volume+=$yellow
	elif ((i == 9)); then
		volume+=$red
	fi
	volume+="❚"
done
volume+=$white

printf "$volume"
