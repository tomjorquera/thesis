#!/bin/bash
# Generates changelog day by day for the last n days

USAGE_STRING="$(basename $0) [-t nbdays]"

short_usage(){
  echo "Usage: $USAGE_STRING"
}

OPT_LAST_N_DAYS=10000000

while getopts ":t" OPT; do
    case $OPT in
      t) shift
	OPT_LAST_N_DAYS=$1;;
      *) short_usage; exit 1 ;;
    esac
done
shift $((OPTIND-1)) # remove optionnal arguments from arg list

if ! [[ $OPT_LAST_N_DAYS =~ ^[0-9]+$ ]] ; then
	exec >&2; echo "error: optional parameter must be a positive number"; exit 1
fi

echo "-----------------------"
echo "CHANGELOG"
echo "-----------------------"
NEXT=$(date +%F)

hg log -d -$OPT_LAST_N_DAYS --template '{date|shortdate}\n' | sort -u -r | while read DATE ; do
	echo
	echo [$DATE]
	hg log -d "$DATE" --no-merges --template '\t{desc}\n' | cat
done
