/*
Author : Rahul Manekari
Date : 3 Feb 2019
Submission : Ripple Coding Challenge

Usage : Fetch the data from rippled's server_info API and calculate the time taken to process each validated ledger.
 */

'use strict';

const delaySeconds = 1;
const decimals = 2;
var data
var timestamp = Math.floor(Date.now() / 1000)
var diff

const RippleAPI = require('ripple-lib').RippleAPI;
const fs = require('fs');


const api = new RippleAPI({
  server: 'wss://s2.ripple.com:443'
});


function getserverinfodata(){


	api.connect().then(function() {
		return api.getServerInfo();
	}).then(function(server_info) {

		// If we already have the details about the existing ledgerversion, skip it
		if(server_info.validatedLedger.ledgerVersion != data){
			// Store the latest ledgerversion in a variable to check above
			data = server_info.validatedLedger.ledgerVersion

			// Get the difference in timestamp of previous ledger and current time.
			diff = Math.floor(Date.now() / 1000) - timestamp

			// Get the new timestamp to store
			timestamp = Math.floor(Date.now() / 1000)

			// Put everything in a flat file to be used by gnuplot script
			var putter = timestamp+"\t"+data+"\t"+diff+"\n";

			console.log("Sequence "+data+" closed in "+diff+" Seconds");
			
			fs.appendFile('plot.dat', putter, function (err) {
				if (err) throw err;
			});
		}

	});

}

// initiate the loop
function loop(){

	getserverinfodata();
	// console.log("CYCLE ENDS ++++++++++++++")
	setTimeout(loop, delaySeconds * 1000);
}

loop();