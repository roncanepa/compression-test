### options here

TESTFILE="test-file.dat"

#This is passed direectly to mkfile, so 1g, 1m, 500k, etc are valid options.
TESTFILESIZE="1g"

# by default, pigz will use -p = $system_cores (real + hyperthreaded)
NUMPROCESSES=2


### script stuff here.
echo "### Beginning compression test script."

echo "checking to see if test-file.dat already exists..."

if [ -f test-file.dat ]
then
	echo "		test-file.dat exists.  skipping creation and md5."
else
	echo "		test-file.dat not found.  creating..."
	mkfile -n $TESTFILESIZE test-file.dat
	echo "		done creating test-file.dat."

	echo "		now md5'ing test-file.dat..."
	md5 test-file.dat
	
	echo "		done with creation and md5.  Moving on to tests."
fi
echo ""
echo ""



echo "running zip test..."
echo "note: using DITTO method that produces the same file that 'compress' in Finder produces (for details, do 'man ditto')"
time ditto -c -k --sequesterRsrc --keepParent "test-file.dat" "test-file.dat.zip"

echo "done with zip test."

echo ""
echo ""

echo "now starting pigz tests.  (Note: by default, pigz deletes the source file if compression is successful. will use -k to suppresss this behavior.)"

echo ""


echo "running pigz test with default settings (including -k to keep source file)"
time pigz -k test-file.dat

# Doesn't seem ossible to give pigz an outfile, so moving the result out of the way to avoid a "do you want to overwrite? (Y/N)" prompt

mv test-file.dat.gz test-file.dat.pigz-defaults.gz
echo ""



echo "running pigz test with -p 2..."
time pigz -k -p $NUMPROCESSES test-file.dat

mv test-file.dat.gz test-file.dat.pigz-n-$NUMPROCESSES.gz
echo ""

echo "done with script."