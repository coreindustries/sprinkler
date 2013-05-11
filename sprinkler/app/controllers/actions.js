var gpio = require("pi-gpio");




var Actions = function () {
  this.respondsWith = ['html', 'json', 'xml', 'js', 'txt'];
  this.pins = {front: 22, garden: 16};

  this.index = function (req, resp, params) {
    this.respond({params: params});
  };

  

  this.turnOn = function (location){
    var p = this.pins[location];
    geddy.log.debug("TURN ON PIN: "+p);

    gpio.open(p, "output", function(err) {
      if(err){ geddy.log.error(JSON.stringify(err)); }
      gpio.write(p, 1, function() { gpio.close(p); });
    });

  }



  this.turnOff = function (location){
    var p = this.pins[location];
    gpio.open(p, "output", function(err) {
        if(err){ geddy.log.error(JSON.stringify(err)); }
        
        gpio.write(p, 0, function() { gpio.close(p); });
      });
  }



    /**
    DEFAULT ACTION HANDLER
    */
  this.show = function (req, resp, params) {


    /**
    TURN BOTH SPRINKLERS ON
    */
    if(params.id == "both_on"){
      geddy.log.debug("**BOTH ON");

      this.turnOn('front');
      this.turnOn('garden');
    }



    /**
    TURN BOTH SPRINKLERS OFF
    */
    if(params.id == "both_off"){
      geddy.log.debug("**BOTH OFF");
      vars.action = "both";

      this.turnOff('front');
      this.turnOff('garden');

    }






    /**
    TURN FRONT SPRINKLERS ON
    */
    if(params.id == "front_on"){
      geddy.log.debug("*FRONT");
      vars.action = "front";
    }
    this.respond({params: params, vars: vars});
  };



};

exports.Actions = Actions;

