#!/bin/sh

OUTPUT_PATH=".."
OUTPUT="phd_progress.pdf"

./phdstats.scala | gnuplot config.gnuplot -e "set output \"$OUTPUT\"; plot '-' using 1:2 title \"word count\""

