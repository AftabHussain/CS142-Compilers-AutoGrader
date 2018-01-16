#!/bin/bash

echo "Backing up unzipped files"

mkdir Backup_unzipped

for studentfolder in .* *; do 
    if [[ $studentfolder == *"full" ]]; then
	echo "Backing up "$studentfolder
  	cp -r $studentfolder $studentfolder".backup"
	mv $studentfolder".backup" Backup_unzipped		
    fi 
done
echo "Done."

