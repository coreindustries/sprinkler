var gpio = require("pi-gpio");
var colors = require('colors');



var Action = function () {

  this.pins = {front: 22, garden: 16};
  var minutes = 1; // 15 min
  this.auto_shutoff_duration = minutes*60*1000; 

  this.defineProperties({
    last_run_start_time: {type: 'datetime'},
    last_run_end_time: {type: 'datetime'},
    currently_running: {type: 'boolean'},
    garden_on: {type: 'boolean'},
    front_on: {type: 'boolean'},
    auto_shutoff: {type: 'datetime'}
  });




  /* the front end calls this with an object
  var o = {
    action: "both_on"
  }
  socket.emit('action', o);
  */
  this.setStatus = function(o){
    console.log("Action.setStatus".bold.red, o);
    // make updates here
    switch (o.action){
      case 'toggle_both':
        // console.log("TURN ON BOTH");
        this.toggleGarden();
        this.toggleFront();
        this.areAllOff();
        break;
      case 'garden':
        this.toggleGarden();
        this.areAllOff();
        break;
      case 'front':
        this.toggleFront();
        this.areAllOff();
        break;
      case 'off':
        this.allOff();
        this.areAllOff();
        break;
    }


    // now that we've updated the action obj
    // set back the result
    return this.getStatus();
  };




  this.getStatus = function(){
    var o = {
      // server_time_epoch: Date(),
      last_run_start_time: this.last_run_start_time,
      last_run_end_time: this.last_run_end_time,
      currently_running: this.currently_running,
      garden_on: this.garden_on,
      front_on: this.front_on,
      auto_shutoff: this.auto_shutoff
    };
    console.log("Action.getStatus".white);
    // console.log(o);
    this.manageAutoShutoff();
    return o;
  };




  this.toggleGarden = function(){
    console.log("toggleGarden");
    if(!this.garden_on){
      this.turnOn('garden');
      this.garden_on = true;
      this.last_run_start_time = Date.now();
      this.calculateAutoShutoff();
    }else{
      this.turnOff('garden');
      this.garden_on = false;
    }

  };


  this.toggleFront = function(){
    console.log("toggleFront");
    if(!this.front_on){
      this.turnOn('front');
      this.front_on = true;
      this.last_run_start_time = Date.now();
      this.calculateAutoShutoff();
    }else{
      this.turnOff('front');
      this.front_on = false;
    }
  };


  /*  TURN OFF a specific pin
  pass in "garden", or "front"
  */
  this.turnOff = function(o){
    console.log("turnOff", o);
    var p = this.pins[o];
    gpio.open(p, "output", function(err) {
      if(err){ geddy.log.error(JSON.stringify(err).underline.red); }
        gpio.write(p, 0, function() {
          gpio.close(p);
      });
    });
  };



  /*  TURN ON a specific pin
  pass in "garden", or "front"
  */
  this.turnOn = function(o){
    console.log("turnOn", o);
    var p = this.pins[o];
    gpio.open(p, "output", function(err) {
      if(err){ geddy.log.error(JSON.stringify(err).underline.red); }
        gpio.write(p, 1, function() {
          gpio.close(p);
      });
    });
  };



  /* loop over our pins, and turn the all off */
  this.allOff = function(){
    console.log("ALL OFF");
    this.garden_on = false;
    this.front_on = false;
    this.currently_running = false;
    this.auto_shutoff = false;

    for(var i in this.pins){
      this.turnOff(i);
    }
  };


  
  // check to see if everythign is off
  // update this.last_run_end_time
  this.areAllOff = function(){
    if(!this.garden_on && !this.front_on){
      this.last_run_end_time = Date.now();
      this.currently_running = false;
      return true;
    }else{
      this.currently_running = true;
      return false;
    }
  };


  // calculate our turn off tim 
  this.calculateAutoShutoff = function(){
    this.auto_shutoff = this.last_run_start_time + this.auto_shutoff_duration;
  };


  // shutus down when when we pass our auto shutoff
  this.manageAutoShutoff = function(){
    // console.log("manageAutoShutoff");
    if(this.auto_shutoff < Date.now() & this.currently_running){
      console.log("** SHUTDOWN **");
      this.allOff();
    }
  };


  // automatically reset our pins on startup
  this.allOff();


};



exports.Action = Action;

