#!/bin/sh

#output file name
OUTPUT="phd_progress"

#generate data
DATA=$(./phdstats.scala)

#draw pdf
echo "$DATA" | gnuplot config.gnuplot -e "set terminal pdfcairo; set output \"$OUTPUT.pdf\"; plot '-' using 1:2"

#draw png
echo "$DATA" | gnuplot config.gnuplot -e "set terminal png; set output \"$OUTPUT.png\"; plot '-' using 1:2"

