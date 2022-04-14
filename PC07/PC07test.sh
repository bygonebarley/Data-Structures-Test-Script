#!/bin/sh
# Author: Jeremy Stevens
# E-mail: jsteve22@nd.edu
# Date: 3/29/2022
# Test file for PC07
#
# This test script will generate new passwords and
# corresponding pin files for those passwords. Then it
# will call the user's PC07 to see if the correct 
# password will be generated. 

# Create folders for input/output files 
mkdir -p wrk
mkdir -p ref
# wrk will contain the generated output files from user's PC05
# ref will contain the input files and the corresponding output files from github 

echo "Making test cases..."
python3 make_test.py 3 test1 > /dev/null
#echo "Test 1"
#cat 1.txt
echo "Password 1: $(cat test1.out)"
echo " "
mv test1.txt tests
mv test1.out ref

python3 make_test.py 10 test2 > /dev/null
#echo "Test 2"
#cat 2.txt
echo "Password 2: $(cat test2.out)"
echo " "
mv test2.txt tests
mv test2.out ref

python3 make_test.py 5 test3 > /dev/null
#echo "Test 3"
#cat 3.txt
echo "Password 3: $(cat test3.out)"
echo " "
mv test3.txt tests
mv test3.out ref

python3 make_test.py 10 test4 > /dev/null
#echo "Test 4"
#cat 4.txt
echo "Password 4: $(cat test4.out)"
echo " "
mv test4.txt tests
mv test4.out ref

python3 make_test.py 10 test5 > /dev/null
#echo "Test 5"
#cat 5.txt
echo "Password 5: $(cat test5.out)"
echo " "
mv test5.txt tests
mv test5.out ref

# Declare variables
WORTH=5
POINTS=0
SECONDS=0

# Download every puzzle input and it's corresponding output file
# 	Files will be saved in ref subfolder

# Compile PC05
echo "Testing ..."
make clean > /dev/null
make PC07 > /dev/null

# For each test, run PC05 with the puzzleX.txt input files and 
# have each output file in the wrk sufolder. If the generated
# .out files are equivalent, delete the files for that test. 
#
# test 1
printf "   %-5s ... " "Sample 1, 1 point"
exe/./PC07 tests/test1.txt wrk/test1.out > /dev/null
diff ref/test1.out wrk/test1.out
if [ $? -ne 0 ]; then
	echo "Failure"
else
	echo "Success"
	let POINTS=$POINTS+1
	rm -rf ref/test1.out wrk/test1.out
fi

# test 2
printf "   %-5s ... " "Sample 2, 1 point"
exe/./PC07 tests/test2.txt wrk/test2.out > /dev/null
diff ref/test2.out wrk/test2.out
if [ $? -ne 0 ]; then
	echo "Failure"
else
	echo "Success"
	let POINTS=$POINTS+1
	rm -rf ref/test2.out wrk/test2.out
fi

# test 3
printf "   %-5s ... " "Sample 3, 1 point"
exe/./PC07 tests/test3.txt wrk/test3.out > /dev/null
diff ref/test3.out wrk/test3.out
if [ $? -ne 0 ]; then
	echo "Failure"
else
	echo "Success"
	let POINTS=$POINTS+1
	rm -rf ref/test3.out wrk/test3.out
fi

# test 4
printf "   %-5s ... " "Sample 4, 1 point"
exe/./PC07 tests/test4.txt wrk/test4.out > /dev/null
diff ref/test4.out wrk/test4.out
if [ $? -ne 0 ]; then
	echo "Failure"
else
	echo "Success"
	let POINTS=$POINTS+1
	rm -rf ref/test4.out wrk/test4.out
fi

# test 5
printf "   %-5s ... " "Sample 5, 1 point"
exe/./PC07 tests/test5.txt wrk/test5.out > /dev/null
diff ref/test5.out wrk/test5.out
if [ $? -ne 0 ]; then
	echo "Failure"
else
	echo "Success"
	let POINTS=$POINTS+1
	rm -rf ref/test5.out wrk/test5.out
fi

# Print time it took to complete
echo "Time: $SECONDS seconds"

# Print the score of PC05 out of total tests
echo "Score: $POINTS / $WORTH"

# delete folders if empty
if [ ! "$(ls -A wrk)" ]; then
	rm -r wrk
fi

if [ ! "$(ls -A ref)" ]; then
	rm -r ref
fi

exit

