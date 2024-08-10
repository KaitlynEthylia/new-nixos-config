#!/usr/bin/env zsh

bold=$(tput bold)
normal=$(tput sgr0)
blue=$(tput setaf 12)
white=$(tput setaf 15)

rawPlayer=$(playerctl --list-all | grep -v 'firefox' | head -1)

title=$(playerctl --player $rawPlayer metadata xesam:title)
artist=$(playerctl --player $rawPlayer metadata xesam:artist)

printf "$blue$bold$title$normal$white - $blue$bold$artist\n"
