/**
 * SPRINKLER DATA ACCESS LAYER
 */

"use strict";
var duration = 15; // minutes
var run_every = 24; // hours
var log4js  = require('log4js');
var sqlite3 = require('sqlite3').verbose();
var db, check_interval;

/*
INSTANTIATE LOGGER
l.trace('Trace'); l.debug("Debug"); l.info("info");
l.warn('Warn');  l.error('Error');  l.fatal('Fatal');
*/
var l = log4js.getLogger('sprinklerDB');
l.setLevel('trace');

l.warn("SPRINKLER DATABASE");

/*

status: currently on or off (1 | 0)
last_run: datetime of the last completed run
duration: minutes to run sprinkler fo
scheduled_stop: if running, this is when we'll stop
scheduled_start: if we're not running, then is when we'll start

*/


// kick things off
first_run();



// returns true|false. true: we're currently running
function getStatus(){

}

// returns an object with date, time
function getLastRun(){

}

// returns an object with date, time
function getScheduleStart(){

}

// returns an object with date, time
function getScheduledStop(){

}

// true|false
function setStatus(status){

}

// ?? needed?
function setLastRun(){

}

// accepts a datetime
function setScheduleStart(datetime){

}

// accepts a datetime
function setScheduledStop(datetime){

}


/*
heartbeat
if we're not running, see if we should be
if we're running, see if we should not be
*/
function check(){
    l.trace("check", run_every, new Date());
}

/*
on the first run through, set up our database and schedule
*/
function first_run(){
    createDb();
    check_interval = setInterval(check,1000);
}








// -- data access funtions below --

function createDb() {
    l.info("createDb");
    db = new sqlite3.Database('sprinkler.sqlite3');
}


function createTable() {
    l.info("createTable sprinkler");
    // db.run("CREATE TABLE IF NOT EXISTS sprinkler (last_date TEXT)", insertRows);
    db.run("CREATE TABLE sprinkler (last_run, status, scheduled_stop, scheduled_start, updated)", insertRows);
}

function insertRows() {
    l.trace("insertRows");

    // var stmt = db.prepare("INSERT INTO sprinkler VALUES (?)");
    // l.debug(stmt);

    for (var i = 0; i < 10; i++) {
    //     stmt.run('CURRENT_TIME');
        db.run("INSERT INTO sprinkler VALUES(NULL, CURRENT_TIMESTAMP, CURRENT_TIME)");
    }

    readAllRows();
    // stmt.finalize(readAllRows);
}

function readAllRows() {
    l.info("readAllRows");

    db.all("SELECT id, last_date, updated FROM sprinkler", function(err, rows) {
        rows.forEach(function (row) {
            l.debug(row.id, row.last_date, row.updated);
        });
        closeDb();
    });
}

function closeDb() {
    l.trace("closeDb");
    db.close();
}

// function runChainExample() {
//     createDb();
// }

// runChainExample();






