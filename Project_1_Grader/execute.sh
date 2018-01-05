#!/bin/bash

testtype=$1

if [[ $testtype == "" ]]; then
	echo "Please enter a name for your test set as follows:"
	echo "./execute.sh [NAME]"
	exit 0
fi 

if [ "$(ls -A "Tests")" ]; then
     echo "Tests folder is not empty."
else
     echo "Tests folder is empty. Please copy your test cases in Tests, then repeat."
     exit 0	
fi



rm "finalOutput."$testtype".csv"     		 
echo "Preparing finalOutput csv file for "$testtype" tests"
echo  "PROJECT_FOLDER_NAME,STUDENT_ID,NAME,UCI_NETID,#"$testtype"_TESTS_PASSED,#"$testtype"_TESTS_FAILED" >> "finalOutput."$testtype".csv"


echo "Scanning each project in CompiledProjects Folder"

for pjt in .* *; do #for each project directory

	if [[ $pjt == *"full" ]]; then #for each project

		totaltestsCount=0
		testPassCount=0
		testFailCount=0

		cd $pjt
      		rm -r *crx* *out* studentInfo.txt studentInfoXtract.txt "."$pjt".summary"

      		echo "### Performing tests in "$pjt" ###"
      		echo "Copied files from Tests folder in "$pjt	
      		cp -r "../Tests/." .
		
      		echo "Copied MyDiff in "$pjt
      		cp -r ../MyDiff.class . 	
      		for testfile in .* *; do
         		if [[ $testfile == *"crx" ]]; then
            			((totaltestsCount++))
            			echo "now running "$testfile" for "$pjt"..."
            			java crux.Compiler $testfile > $testfile".studentOut" 

            			echo "performing MyDiff..."
            			java MyDiff $testfile".studentOut" ${testfile%.crx}".out" > $testfile".mydiff"

            			mydiffsize=$( wc -l < $testfile".mydiff" )

            			if [[ $mydiffsize == "0" ]]; then
            
              				echo $testfile" passed."
            
              				mv $testfile $testfile".studentOut" ${testfile%.crx}".out" $testfile".mydiff" results/passedtests

              				((testPassCount++))
            			else
              				echo $testfile" failed."

              				mv $testfile $testfile".studentOut" ${testfile%.crx}".out" $testfile".mydiff" results/failedtests

              				((testFailCount++))
            			fi  
			fi
		done

		####Getting the Results#####

      		summary="TESTS:"$testtype", TOTAL TESTS:"$totaltestsCount", TOTAL PASSED:"$testPassCount", TOTAL FAILED:"$testFailCount
      		echo $summary > $testtype"."$pjt".summary"
      		grep studentID crux/Compiler.java &>> studentInfo.txt
      		grep studentName crux/Compiler.java &>> studentInfo.txt
      		grep uciNetID crux/Compiler.java &>> studentInfo.txt
      		grep -o '".*"' studentInfo.txt | sed 's/"//g' &>> studentInfoXtract.txt 
      		studentFinalData=$pjt","
      		while read line; do
        		studentFinalData=$studentFinalData$line","
      		done < studentInfoXtract.txt 
      		studentFinalData=$studentFinalData$testPassCount","$testFailCount

   		cd ..
		echo "Storing student info in finalOutput csv file"
		echo $studentFinalData >> "finalOutput."$testtype".csv"
	fi
done


    
