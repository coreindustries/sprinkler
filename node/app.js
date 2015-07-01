var express = require('express')
	, bodyParser = require('body-parser')
	, compression = require('compression')
	, responseTime = require('response-time')
    , router = express.Router()
    , http = require('http')
    , path = require('path')
    , log4js = require('log4js');


 /*
INSTANTIATE LOGGER
l.trace('Trace'); l.debug("Debug"); l.info("info");
l.warn('Warn');  l.error('Error');  l.fatal('Fatal');
*/
var l = log4js.getLogger('sprinkler');
l.setLevel('trace');


l.warn("\n\n----\n"+("Sprinkler System started")+"\n----\n");



// WEBSITE
var app = express();
// var api = require('./routes/api');
// var control = require('./routes/control');
var expressPort = 3000;

// all environments
// console.log('process.env.PORT: ', process.env.PORT);
app.set('port', expressPort);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
// app.use(express.favicon());
// app.use(express.logger('dev'));
app.use(bodyParser.json());
app.use(responseTime(5));
app.use(compression());
// app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  // app.use(express.errorHandler());
}

// simple logger for this router's requests
// all requests to this router will first hit this middleware
router.use(function(req, res, next) {
  console.log('%s %s %s', req.method, req.url, req.path);
  next();
});

app.use('/', router);
// app.get('/', routes.index);
// app.get('/api', api.index);
// app.get('/api/latency', api.latency);
// app.get('/api/wifi', api.wifi);
// app.get('/control', control.index);

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port '.verbose + expressPort);
});


