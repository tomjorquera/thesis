#!/bin/sh

#needed for me as the scala installed in bin is too old
export PATH=/home/jorquera/Documents/scala/scala-2.10.0-RC5/bin/:$PATH

OUTPUT_PATH=".."
OUTPUT="phd_progress.pdf"

./phdstats.scala | gnuplot config.gnuplot -e "set output \"$OUTPUT\"; plot '-' using 1:2 title \"word count\""

