#### inline-edit
Helper python application that can be used to edit the Complex and Scheduler configs for N1GE. It overwrites the EDITOR variable and puts the content of the specified CONFIGFILE in place. -f and -t are required options. Assumes that SGE's settings.sh file has already been sourced. Current ENV is copied used when calling qconf

`usage: inline-edit [-h] [-f CONFIGFILE] [-t {mc,msconf}] [TMPFILE]`
