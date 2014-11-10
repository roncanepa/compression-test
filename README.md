compression-test
================

testing to see how much faster pigz is than native zip on OSX.

this script uses pigz ('Parallel gzip', http://zlib.net/pigz/), which is not installed by default.

if you don't have it and you use homebrew, install it by: brew install pigz

Note: both pigz/unpigz and gzip/gunzip remove the input files by default if successful.  supress this behavior with the -k flag, if relevant.
