# ripple-challenge

#	Live Demo
https://1drv.ms/v/s!At0cFJuLVakD1VFYQMhC5Dka8MVk
(One Drive link, or check the Video inside the repo)

#	Documentation

#	Installation

1) Clone this repository
2) Install gnuplot (mac)

```sh
$ brew install gnuplot
```

3) Install nodejs
https://nodejs.org/en/download/

4) Install the required packages

```sh
$ npm install
```

#	Execution

To start the project, navigate to project directory, and execute the following commands

```sh
$ chmod u+x run.sh
$ ./run.sh
```



#	File Structure
 - **gnuplot_script.gp** (gnuplot script to plot the flat file data in a gnuplot QT graph viewer)
 - **index.js** (Node JS script to call rippled's server_info API through WebSocket and store the sequence info in flat file "plot.dat")
 - **package.json** (npm packages to be installed before running this project)
 - **plot.dat** (flat file, where the index.js will store the sequence and time information, and this file will be used by gnuplot_script.gp)
 - **run.sh** (project initiator, to start the project, run this file)
 
 #	Screenshot
 
 [![Screenshot](https://i.ibb.co/kSNPndv/Screenshot-2019-02-03-at-6-28-17-PM.png)]

#	Questions

1) How does your script work?
To execute the script, the steps are mentioned above. run.sh is responsible to start the nodejs script which will start calling the rippled's api and store the data into plot.dat file. 
After 15 seconds you execute run.sh, gnuplot is executed with the script file (gnuplot_script.gp) which will fetch the data from plot.dat file and plot the graph. 

 - index.js is a continuous script which wont end unless you hit ctrl+c or end the process through kill command. 
 
2) How did you decide on your polling interval?
 - rippled's server_info API is executed every single second to fetch the data. I have noticed that the time taken by the rippled to process the ledger is not fixed, sometime it may take a second and sometime it may take more than 5 seconds. 
 
3) What do the results tell you?

 - Approximately 3 seconds it takes on an average to close a ledger sequence. Sometimes, its 1 seconds, and sometimes i found it took 8 seconds. 
 
 
4) What might explain the variation in time between new ledgers?

 - Time taken to close the ledger is equal to time taken to have a consensus from N number of peers in ripple network. When a single consensus round completes, peer releases a signature and distributes across the network, which then received by the peers over the network. Once majority of the signatures found similar, the round is passed. When the received validation is not cleared from majority of the nodes, the consensus round is discarded and again validated over the network before processing any new transaction. Thus making a delay in closing a single ledger.  


# 	Bonus question #1:

Enhance your script to calculate the min, max, and average time that it took for a new ledger to be validated during the span of time captured.
 
 - In this project - Min, Max and average is being calculated via gnuplot script by taking a sample of latest 10 entries made in plot.dat file. The data is displayed in top left corner of gnuplor graph.

#	Bonus question #2:
 
There are some other (better) ways that you could use the rippled API to find how long each ledger took to close/validate. Using the API documentation, find and describe one of these methods (you don’t need to actually implement it).

 - I was going through the information available on APi documentation, and found out there are couple of APIs available which provides the sequence number of latest closed/in-progress ledger, but I feel the api call **"ledger_closed"** is dedicated to fetch the most recently closed ledger. 



