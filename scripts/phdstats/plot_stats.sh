#!/bin/sh

#output file name
OUTPUT="phd_progress"

#generate data
DATA=$(./phdstats.scala)

#draw pdf
echo "$DATA" | gnuplot config.gnuplot -e "set terminal pdfcairo; set output \"$OUTPUT.pdf\"; plot '-' using 1:2"

#draw png
echo "$DATA" | gnuplot config.gnuplot -e "set terminal png; set output \"$OUTPUT.all.png\"; plot '-' using 1:2"

#draw png of 7, 14 and 30 last days
CURR_DATE=$(date +"%Y-%m-%d" --date="tomorrow") #add tomorrow to have larger x-axis
DATE_7DAYS=$(date +"%Y-%m-%d" --date="8 days ago") #add a day before for same reason
DATE_14DAYS=$(date +"%Y-%m-%d" --date="15 days ago") #add a day before for same reason
DATE_30DAYS=$(date +"%Y-%m-%d" --date="31 days ago") #add a day before for same reason
echo "$DATA" | gnuplot config.gnuplot -e "set format x \"%d/%m\";set xrange [\"$DATE_7DAYS\":\"$CURR_DATE\"];set terminal png; set output \""$OUTPUT".7days.png\"; plot '-' using 1:2"
echo "$DATA" | gnuplot config.gnuplot -e "set format x \"%d/%m\";set xrange [\"$DATE_14DAYS\":\"$CURR_DATE\"];set terminal png; set output \""$OUTPUT".14days.png\"; plot '-' using 1:2"
echo "$DATA" | gnuplot config.gnuplot -e "set format x \"%d/%m\";set xrange [\"$DATE_30DAYS\":\"$CURR_DATE\"];set terminal png; set output \""$OUTPUT".30days.png\"; plot '-' using 1:2"
