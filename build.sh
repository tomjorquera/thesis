########
# target directories related variables
LIBS="libs"  #dependencies folder name
OUT="generated"  #output folder name
########


########
# Usage

USAGE_STRING="$(basename $0) [-ls] texfilename(without .tex extension)"

short_usage(){
  echo "Usage: $USAGE_STRING"
}

long_usage() {
  echo "USAGE:"
  echo "  $USAGE_STRING"
  echo
  echo "OPTIONS:"
  echo "  -l	move the log files to the current folder (if needed by another application for example)"
  echo "  -s	show the generated pdf at the end of generation)"
  echo
}

if [ $# = 0 ]; then
  long_usage
  exit 0
fi
########

######## SCRIPT START ############

########
# read optionnal arguments

OPT_MOVE_LOG=0 # set to 1 to move log file to current folder
OPT_SHOW_PDF=0 # set to 1 to show the pdf at the end of generation

while getopts ":ls" OPT; do
    case $OPT in
      l) OPT_MOVE_LOG=1;;
      s) OPT_SHOW_PDF=1;;
      *) short_usage; exit 1 ;;
    esac
done
shift $((OPTIND-1)) # remove optionnal arguments from arg list
########

# check if tex file exists
if [ ! -f $1.tex ]; then
  echo "file $1.tex does not exists" 1>&2
  short_usage
  exit 1
fi

# add local folders to the latex dependencies path
export TEXINPUTS=$TEXINPUTS:.:./$LIBS

#do the same for bibtex
export BSTINPUTS=$BSTINPUTS:.:./$LIBS

# check if output folder exists, if not create it
if [ ! -d $OUT ]; then
    mkdir $OUT
fi

# set output folder of bibtex
TEXMFOUTPUT=./$OUT

########
# generation workflow (as seen on texmaker)

# generate first version (for .aux used by bibtex)
pdflatex -interaction=nonstopmode -output-directory=./$OUT $1.tex

# generate bib
bibtex ./$OUT/$1.aux

# generate final pdf (why do pdflatex two times ? Because LateX, that's why)
pdflatex -interaction=nonstopmode -output-directory=./$OUT $1.tex
asy ./$OUT/$1.asy
pdflatex -interaction=nonstopmode -output-directory=./$OUT $1.tex

########

# show pdf if the option is set
if [ $OPT_SHOW_PDF = 1 ]; then
  evince ./$OUT/$1.pdf &
fi


# move logs if relevant option was set
if [ $OPT_MOVE_LOG = 1 ]; then
  mv ./$OUT/$1.log ./. # latex log
  mv ./$OUT/$1.blg ./. # bibtex log
fi
