#!/bin/bash

echo "Decompressing student submission into new folder"
submissionCount=0
for zippedFile in .* *; do 
    if [[ $zippedFile == *"zip" ]]; then
  	unzip $zippedFile -d $zippedFile".full" #unzip the folder into a new one|MAKE SURE THERE ARE NO SPACES IN THE ZIP FILE NAME.
  	((submissionCount++)) 
	fi
done
msg0="Decompressed "$submissionCount" project(s)"
echo $msg0
