# NOTE: When executed from hook PWD is the base folder of the repository


# we are forking all the process to avoid blocking on the push
# don't think is really dangerous as we do nothing critical
# but can cause some errors on the scripts (for example if rollback during plot_stats)
{

# needed for me as the scala installed in bin is too old
# can be removed is installed version of scala is recent enough
export PATH=/home/jorquera/Documents/scala/scala-2.10.0-RC5/bin/:$PATH

# generate new pdf (discard stdout, and stderr also else else very wierd as non blocking)
./build.sh -l manuscrit >/dev/null 2>&1

# generate stats
cd "./scripts/phdstats/"
./plot_stats.sh

# move files to public
PATH_TO_PUBLIC_FOLDER="../../../Public/thesis"

cd "-" >/dev/null #discard stdout
cp ./generated/manuscrit.pdf $PATH_TO_PUBLIC_FOLDER/.
cp ./scripts/phdstats/phd_progress.pdf $PATH_TO_PUBLIC_FOLDER/. 

} &
