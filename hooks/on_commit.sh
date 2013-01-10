# NOTE: When executed from hook PWD is the base folder of the repository

# needed for me as the scala installed in bin is too old
# can be removed is installed version of scala is recent enough
export PATH=/home/jorquera/Documents/scala/scala-2.10.0-RC5/bin/:$PATH

# generate new pdf
./build.sh -l manuscrit

# generate stats
cd "./scripts/phdstats/"
./plot_stats.sh

# move files to public
PATH_TO_PUBLIC_FOLDER="../../../Public/thesis"

cd "-"
cp ./generated/manuscrit.pdf $PATH_TO_PUBLIC_FOLDER/.
cp ./scripts/phdstats/phd_progress.pdf $PATH_TO_PUBLIC_FOLDER/.
