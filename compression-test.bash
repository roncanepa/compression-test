### options here

#TESTFILE="test-file.dat"
TESTFILE="rons-test-file.ext"

#This is passed direectly to mkfile, so 1g, 1m, 500k, etc are valid options.
TESTFILESIZE="5m"

# by default, pigz will use -p = $system_cores (real + hyperthreaded)
NUMPROCESSES=2


### script stuff here.
echo ""
echo "#######################"
echo "### Beginning compression test script."
echo ""
echo "note: this script uses pigz ('Parallel gzip', http://zlib.net/pigz/), which is not installed by default."
echo "if you don't have it and you use homebrew, install it by: brew install pigz."
echo ""

echo "checking to see if $TESTFILE already exists..."

if [ -f "$TESTFILE" ]
then
	echo "		$TESTFILE exists.  skipping creation."
else
	echo "		$TESTFILE not found.  creating..."
	echo "command: mkfile -n $TESTFILESIZE $TESTFILE"
	mkfile -n $TESTFILESIZE $TESTFILE
	echo "		done creating $TESTFILE ."


	echo "		done with creation.  Moving on to tests."
fi
echo ""
echo ""


echo "#######################"
echo "running zip test..."
echo "note: using DITTO method that produces the same file that 'compress' in Finder produces (for details, do 'man ditto')"
echo "command: time ditto -c -k --sequesterRsrc --keepParent '$TESTFILE' $TESTFILE.zip'"
time ditto -c -k --sequesterRsrc --keepParent "$TESTFILE" "$TESTFILE.zip"

echo "done with zip test."

echo ""
echo ""

echo "#######################"
echo "now starting pigz tests.  (Note: by default, pigz deletes the source file if compression is successful. will use -k to suppresss this behavior.)"

echo ""


echo "running pigz test with default settings (including -k to keep source file)"
time pigz -k $TESTFILE

# Doesn't seem ossible to give pigz an outfile, so moving the result out of the way to avoid a "do you want to overwrite? (Y/N)" prompt

mv "$TESTFILE.gz" "$TESTFILE.pigz-defaults.gz"
echo ""
echo ""



echo "running pigz test with -p 2..."
time pigz -k -p $NUMPROCESSES $TESTFILE

mv $TESTFILE.gz $TESTFILE.pigz-n-$NUMPROCESSES.gz
echo ""
echo ""

echo "done with compression."
echo ""

echo "if you'd like to test your results (by using md5, for instance), you can do so now.  Be sure to specify the -k flag to both unpigz and gunzip to keep your input files if you so desire."
echo ""

echo "done with script."