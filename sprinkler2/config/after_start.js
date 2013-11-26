geddy.io.sockets.on('connection', function (socket) {
  
  // socket.emit('news', { hello: 'world' });
  
  // socket.on('my other event', function (data) {
  //   console.log(data);
  // });

	socket.on('status', function (data) {
		socket.emit('response', geddy.model.Action.getStatus());
	});

	socket.on('action', function (data) {
		console.log(data);
		socket.emit('response', geddy.model.Action.setStatus(data));
	});
});