/**
 * Shows how to use chaining rather than the `serialize` method.
 */
"use strict";

var log4js  = require('log4js');
var sqlite3 = require('sqlite3').verbose();
var db;

/*
INSTANTIATE LOGGER
l.trace('Trace'); l.debug("Debug"); l.info("info");
l.warn('Warn');  l.error('Error');  l.fatal('Fatal');
*/
var l = log4js.getLogger('servo');
l.setLevel('trace');

function createDb() {
    l.info("createDb chain");
    db = new sqlite3.Database('sprinkler.sqlite3', createTable);
}


function createTable() {
    l.info("createTable sprinkler");
    // db.run("CREATE TABLE IF NOT EXISTS sprinkler (last_date TEXT)", insertRows);
    db.run("CREATE TABLE sprinkler (id INTEGER PRIMARY KEY AUTOINCREMENT, last_date, updated)", insertRows);
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

function runChainExample() {
    createDb();
}

runChainExample();