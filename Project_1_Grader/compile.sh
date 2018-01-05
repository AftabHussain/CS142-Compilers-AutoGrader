#!/bin/bash

echo "Compiling all projects..."

echo "Created CompiledProjects Folder"
mkdir CompiledProjects

echo "Created Tests folder in CompiledProjects Folder"
mkdir CompiledProjects/Tests

echo "Created UncompiledProject Folder"
mkdir UncompiledProjects
echo "STUDENT_PROJECT,COMPILE_ERRORS,NOT_FOUND_ERRORS" >> "UncompiledProjects/compileErrors.csv"

cp MyDiff.java MyDiff.class CompiledProjects
echo "Copied MyDiff to CompiledProjects"

cp execute.sh CompiledProjects
echo "Copied execute.sh to CompiledProjects"


compileFailCount=0
compilePassCount=0

for studentproject in .* *; do #scan all files in directory

    if [[ $studentproject == *"full" ]]; then #for each unzipped student folder
    	
		echo "Compiling "$studentproject"..."
		cd $studentproject
		(javac -Xlint crux/Compiler.java)>& compile.log #  compile 
        	errors=$(grep -r error compile.log)		
		notfound=$(grep -r not[[:space:]]found compile.log)

		if [[ $errors == "" ]] && [[ $notfound == "" ]]
		then	
			echo "Preparing results folders..."
  			mkdir results
  			mkdir results/passedtests
  			mkdir results/failedtests
			cd ..	
  			echo "Compiled! Moving "$studentproject" to CompiledProjects Folder"
			mv $studentproject CompiledProjects
  			((compilePassCount++))

  		else
  			echo "Failed Compilation. Moving "$studentproject" to UncompiledProjects Folder..."
			cd ..	
			mv $studentproject UncompiledProjects	

			echo "storing error in compileErrors csv file"
			echo $studentproject","$errors","$notfound >> "UncompiledProjects/compileErrors.csv"
			echo "See compile.log."
  			((compileFailCount++)) 
  		fi	
	fi	
done

msg3="Successfully compiled "$compilePassCount" project(s)"
echo $msg3
msg4="Failed to compile "$compileFailCount" project(s)"
echo $msg4


