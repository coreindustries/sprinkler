var io = require('socket.io').listen(80);

io.sockets.on('connection', function (socket) {
  socket.emit('hello', { hello: 'world' });
  var t = setInterval(function(){
  	socket.emit('time', { time: 'time' });
  }, 1000);
  socket.on('my other event', function (data) {
    console.log(data);
  });
});

