
######################################################
#Author : Rahul Manekari
#Date : 3 Feb 2019
#Submission : Ripple Coding Challenge

#Usage: Get the data from the flat file "plot.dat" and plot the graph in gnuplot QT viewer

######################################################






set grid ytics mytics  # draw lines for each ytics and mytics
set mytics 1           # set the spacing for the mytics

set grid xtics mxtics  # draw lines for each xtics and mxtics
set mxtics 5           # set the spacing for the mxtics

set grid               # enable the grid


set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 15 pi -1 ps 1.5
set pointintervalbox 3

set xlabel "Time"
set ylabel "Sequence" 
set timestamp

set timefmt '%s'
set xdata time
set format x "%H:%M:%S"

set format y "%.1f"




plot "<(tail -10 plot.dat)" using 1:2:(sprintf("(Seq %d closed in %d Seconds)", $2, $3)) with linespoints ls 1 notitle,\
	"" using 1:2:(sprintf("(Seq %d closed in %d Seconds)", $2, $3)) with labels point pt -1 offset char 1,1 notitle 


tmin = 0
tmax = 0

tmin=`tail -10 plot.dat | cut -c 21 | sort -n | head -1` #0
tmax=`tail -10 plot.dat | cut -c 21 | sort -n | tail -1` #0

tavg = (tmin+tmax)/2

set label (sprintf("(Min = %d Second)", tmin)) at graph 0.15,0.95
set label (sprintf("(Max = %d Second)", tmax)) at graph 0.15,0.9
set label (sprintf("(Average = %d Second)", tavg)) at graph 0.15,0.85



# refresh the script every 3 second to plot the updated data from the flat file plot.dat.
 
while (1) {
    replot
    pause 3
}