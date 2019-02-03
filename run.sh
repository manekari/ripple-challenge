#!/bin/bash
echo "=================================================================="
echo "Wait for 15 Seconds to to gather some initial data to plot"
echo "=================================================================="
node index.js &
sleep 15

echo "=================================================================="
echo "Initiate Plotting"
echo "=================================================================="
gnuplot gnuplot_script.gp