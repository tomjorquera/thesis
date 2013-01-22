# Note: the texmaker command should be "bash /path/to/script/texmakerbuilder.sh"
# else the variable BASH_SOURCE will not be set

# this one-liner get the directory where the script is located
# (from http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#go to root folder
cd $DIR/..

#launch build
exec ./build.sh -ls manuscrit
