var io = require('socket.io').listen(8001);

io.sockets.on('connection', function (socket) {
  socket.emit('hello', { hello: 'world' });
  
  var t = setInterval(function(){
  	var d = new Date();
  	socket.emit('time', { time: d });
  }, 1000);
  socket.on('my other event', function (data) {
    console.log(data);
  });
});

