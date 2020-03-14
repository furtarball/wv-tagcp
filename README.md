# wv-tagcp
is a tool that allows you to painlessly copy tags to WavPack files.

## Dependencies
* bash
* wavpack
* sox

## Usage
`wv-tagcp.sh [infile] [outdir]`

You can use wildcards in the first argument. Files in the output directory must be named the same as the input ones (except the extension, of course).

Check what tags your input files contain using `sox -c`. Then, tell wv-tagcp how it should copy them – match them with the ones listed at http://wiki.hydrogenaud.io/index.php?title=APE_key. Pass this information in the following format:
````
title:Title
artist:Artist
date:Year
````
A short list has already been added to the beginning of this script.
