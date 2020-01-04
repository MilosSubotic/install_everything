#!/bin/sh
# This script is used with Worker commander for moving delited files into trash.
# Instalation:
# For use this script you have to set up Worker:
# open Worke Configuration (click C button in left upper corner of window above left list view bar) 
# -> go to Button Configuration -> 3. click on DELETE button to edit it -> click Add command -> own command 
# -> start mode set to normal mode -> in program edit write: {vHOME}/.worker/scripts/WorkerMoveToTrash.sh {A}
# -> Ok -> Add command -> Reload -> Ok -> Ok -> Save.
# Then make folder: mkdir $HOME/.worker/scripts/
# and copy this script in it.

# trash folders:
TrashFiles="$HOME/.local/share/Trash/files/"
TrashInfo="$HOME/.local/share/Trash/info/"

# Function for moving files in trash and making trashinfo for their later restore.
# TODO: This version of script don't put deletion time and date in trashinfo!
Move()
{

	file=${1##*/}										# Extract filename from path.
	if [ -z $(ls -a $TrashFiles | grep -x "$file") ] 	# If don't exist file in trash with same name like $file?
	then												# Then move file to trash with original filename
		mv "$1" "$TrashFiles$file"						# and make trashinfo file with filename.trashinfo filename.
		echo "[Trash Info]
Path=$1
DeletionDate="`date +%FT%T` > $TrashInfo$file".trashinfo"
	else												# Else there is already file with same filename.
		base=${file%%.*}								# Extract base and extension from filename
		ext=${file#*.}
		if [ "$base" != "$ext" ]						# If base and extension are not same?
		then
			ext="."$ext									# Then extension get all fullstops.
		else
			ext=""										# Else there is no extension.
		fi
		num=2
		while :											# Putting numbers biger than 1 between base and extension
		do												# And seek for first free name with that number.
			if [ -z $(ls -a $TrashFiles | grep -x "$base.$num$ext") ]
			then
				mv "$1" "$TrashFiles$base.$num$ext"
				echo -e "[Trash Info]
Path=$1
DeletionDate="`date +%FT%T` > "$TrashInfo$base.$num$ext.trashinfo"
				break
			else
				num=$( expr $num + 1 )
			fi
		done
	fi	

}

# Begin of script.
# Worker send to this script absolute paths to files witch have to be delete,
# so if there is white space in absolute path path will be divided in a few positional parameters.
# Every positional parameter witch don't begin with $HOME/ is just an extend of last finded path 
# witch begin with $HOME/. It is posible an error by wrong interpetion if there is * $HOME/ in path
# sended by Worker.

bool=0
for param
do
	echo $param
	Move "$param"
done


exit 0
