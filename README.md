compression-test
================

## Background

I often work with large text files full of next-gen sequencing data and I wanted to see if there was a quicker way to compress them in OSX.

This script uses pigz ('Parallel gzip', http://zlib.net/pigz/), which is not installed by default.

if you don't have it and you use homebrew, install it by: 
````brew install pigz

**Note**: both pigz/unpigz and gzip/gunzip remove the input files by default if successful.  supress this behavior with the -k flag, if relevant.

## TL;DR

* Files created using `mkfile` gave similar performance and compression as real sequence data, so I decided to keep using it for testing purposes.
* pigz gives vastly faster compression times, as expected.
* zip files were compressed slightly more, but IMHO not enough to warrant the increased time
* I read somewhere that multi-threaded processors share the same cache.  Experimenting with -p  (# of actual cores) for pigz gave slower performance than defaults.



## Usage

You can run it as-is:

````./compression-test.bash````

The default is to create a 1GB test file for use in compression tests.

To adjust the test file size, modify the script and change the following line:

````
#This is passed direectly to mkfile, so 1g, 1m, 500k, etc are valid options.
TESTFILESIZE="1g"
````

and then delete the old file (if it exists) from your directory.

