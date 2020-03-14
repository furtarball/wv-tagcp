#!/bin/bash

if [ ! -d "${@: -1}" ];
then
	printf "USAGE: wv-tagcp.sh [infiles] [outdir]\n"
	printf "files in outdir must be named the same as infiles\n"
	printf "(except the extension, of course)\n"
	exit
fi

clear
printf "wv-tagcp 1.0\n"
wvtag -v
sox --version

tags=(Album:Album Artist:Artist Title:Title Tracknumber:Track Year:Year album:Album\
	artist:Artist composer:Composer copyright:Copyright date:Year genre:Genre\
	genre:Genre labelid:Catalog language:Language title:Title tracknumber:Track)

printf "\n`tput bold`Which tags would you like to copy?`tput sgr0`\n"
printf "You can find a list of them using soxi -a; this script\n"
printf "converts ID3/Ogg comments to APE  –  the Hydrogenaudio\n"
printf "Knowledgebase contains a  complete  list  of APE keys.\n"
printf "Match  original tags  to APE ones  using  this format:\n"
printf "  title:Title, album:Album, artist:Artist, date:Year\n"
printf "Separate  entries  with  Enter;  finish  with  Ctrl-D.\n"
printf "  http://wiki.hydrogenaud.io/index.php?title=APE_key\n"
printf "A short list of tags has already been added to the be-\n"
printf "ginning of this script.\n"
printf ": "
while read answer
do
	tags=("${tags[@]}" $answer)
done
printf "\nCopying…\n"

if [ $tags ];
then
	for i in "$@"
	do
		if [ "$i" = "${@: -1}" ]
		then
			printf "Done.\n"
			exit
		fi
		eval $(soxi -a "$i" | sed -e 's/=/="/' -e 's/$/"/')
		for (( j=0; j<${#tags[*]}; j++ ))
		do
			wvtag -q -w "$(echo ${tags[j]#*:}=`eval echo '$'${tags[j]%:*}`)" \
			"${@: -1}`echo ${i##*/} | head -c-5`wv"
		done
	done
else
	printf "No answer: exiting\n"
fi
