var gpio = require("pi-gpio");



var Actions = function () {
  this.respondsWith = ['html', 'json', 'xml', 'js', 'txt'];

  this.index = function (req, resp, params) {

    this.respond({params: params});
  };



  this.show = function (req, resp, params) {
    geddy.log.debug(this.name+" CONTROLLER : "+params.id);
    var vars = {};


    /**
    TURN BOTH SPRINKLERS ON
    */
    if(params.id == "both_on"){
      geddy.log.debug("**BOTH ON");
      vars.action = "both";



      gpio.open(22, "output", function(err) {        // Open pin 16 for output
        if(err){ geddy.log.error(JSON.stringify(err)); }
        
        gpio.write(22, 1, function() {            // Set pin 16 high (1)
          geddy.log.debug('*** GPIO ON');
          gpio.close(22);                        // Close pin 16
        });
      });
    }



    /**
    TURN BOTH SPRINKLERS OFF
    */
    if(params.id == "both_off"){
      geddy.log.debug("**BOTH OFF");
      vars.action = "both";



      gpio.open(22, "output", function(err) {        // Open pin 16 for output
        if(err){ geddy.log.error(JSON.stringify(err)); }
        
        gpio.write(22, 0, function() {            // Set pin 16 high (1)
          geddy.log.debug('*** GPIO ON');
          gpio.close(22);                        // Close pin 16
        });
      });
    }







    if(params.id == "front"){
      geddy.log.debug("*FRONT");
      vars.action = "front";
    }
    this.respond({params: params, vars: vars});
  };



};

exports.Actions = Actions;

