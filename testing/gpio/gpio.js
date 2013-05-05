var gpio = require("pi-gpio");

var state = 0; //off by default

var to = setInterval(toggle, 3000);



function toggle(){
	if(state){
		state = 0;
	}else{
		state = 1;
	}
	
	gpio.open(22, "output", function(err) {        // Open pin 16 for output
	if(err){
		console.log(err);
	}
	gpio.write(22, state, function() {            // Set pin 16 high (1)
    	console.log('state', state);
        gpio.close(22);                        // Close pin 16
    });
});

}
