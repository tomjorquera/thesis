########
# target directories related variables
SOURCES="sources" #sources folder name
LIBS="libs"  #dependencies folder name
OUT="generated"  #output folder name
########


########
# Usage

USAGE_STRING="$(basename $0) [-lsf] texfilename(without .tex extension)"

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
  echo "  -f	fast build - only do one pdflatex run"
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
OPT_FAST_BUILD=0 #set to 1 to make a fast build (only one pdflatex run)

while getopts ":lsf" OPT; do
    case $OPT in
      l) OPT_MOVE_LOG=1;;
      s) OPT_SHOW_PDF=1;;
      f) OPT_FAST_BUILD=1;;
      *) short_usage; exit 1 ;;
    esac
done
shift $((OPTIND-1)) # remove optionnal arguments from arg list
########

# check if tex file exists
if [ ! -f ./$SOURCES/$1.tex ]; then
  echo "file $1.tex does not exists" 1>&2
  short_usage
  exit 1
fi

# add local folders to the latex dependencies path
export TEXINPUTS=$TEXINPUTS:./$SOURCES:./$LIBS

#do the same for bibtex
export BIBINPUTS=$BIBINPUTS:./$SOURCES	#where to find bib files
export BSTINPUTS=$BSTINPUTS:./$LIBS	#where to find bib style files

# check if output folder exists, if not create it
if [ ! -d $OUT ]; then
    mkdir $OUT
fi

# set output folder of bibtex
TEXMFOUTPUT=./$OUT

########
# generation workflow (as seen on texmaker)

# generate first version (for .aux used by bibtex)
pdflatex -interaction=nonstopmode -output-directory=./$SOURCES/$OUT $1.tex

if [ $OPT_FAST_BUILD = 0 ]; then	#full build
	# generate bib
	bibtex ./$OUT/$1.aux

	# generate final pdf (why do pdflatex two times ? Because LateX, that's why)
	pdflatex -interaction=nonstopmode -output-directory=./$OUT ./$SOURCES/$1.tex	# first one to insert reference indicators
	asy ./$OUT/$1.asy
	pdflatex -interaction=nonstopmode -output-directory=./$OUT ./$SOURCES/$1.tex	# second one to refine citation ref and other cross-ref
fi
########

# show pdf if the option is set
if [ $OPT_SHOW_PDF = 1 ]; then
  evince ./$OUT/$1.pdf &
fi


# move logs if relevant option was set
if [ $OPT_MOVE_LOG = 1 ]; then
  mv ./$OUT/$1.log ./. # latex log
  if [ $OPT_FAST_BUILD = 0 ]; then	#if full build was done, move bibtex log
  	mv ./$OUT/$1.blg ./. # bibtex log
  fi
fi
