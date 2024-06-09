#!/usr/bin/env zsh

bold=$(tput bold)
normal=$(tput sgr0)

white=$(tput setaf 15)

rawPlayer=$(playerctl --list-all | grep -v 'firefox' | head -1)

rawShuffle=$(playerctl --player $rawPlayer shuffle)
shuffle=$(case $rawShuffle in
	On) 
		echo "󰒟 ";;
	Off)
		echo "󰒞 ";;
	*)
		echo "  ";;
esac)

rawStatus=$(playerctl --player $rawPlayer status)
_status=$(case $rawStatus in
	Playing)
		echo " ";;
	Paused) 
		echo " ";;
esac)

rawLoop=$(playerctl --player $rawPlayer loop)
loop=$(case $rawLoop in
	Playlist)
		echo "󰑖 ";;
	Track)
		echo "󰑘 ";;
	None) 
		echo "󰑗 ";;
	*)
		echo "  ";;
esac)

printf "$white$shuffle $bold󰒮 $_status󰒭 $normal $loop"