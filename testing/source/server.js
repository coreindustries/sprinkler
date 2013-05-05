var io = require('socket.io').listen(8001);

var default_run_time_min = 15;
var default_run_time_milli = default_run_time_min * 60 * 60;
var time_remaining = 0;
var running = false;
var last_run = {date_time: undefined, duration:0};

io.sockets.on('connection', function (socket) {

	// update the clock display every second
	var t = setInterval(function(){
		var d = new Date();
		if(running){
			last_run.duration = d - last_run.date_time;
		}
		socket.emit('time', 
			{ 
				time: d, 
				running: running,
				last_run: last_run.date_time,
				duration: last_run.duration 
			});
	}, 1000);

	// handle on/off button
	socket.on('toggle_button', function (data) {
		console.log("toggle_button", data);
		if(data.button == "on" && !running){
			turn_system("on");
		}
		if(data.button == "off"){
			turn_system("off");
		}
	});

	// turn the system on or off
	function turn_system(way){
		if(way == "on"){
			running = true;
			last_run.date_time = new Date();
		}

		if(way == "off"){
			running = false;
		}

		// udpate the UI
		socket.emit('status', { running: running });

	}
});

