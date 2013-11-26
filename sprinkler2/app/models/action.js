var gpio = require("pi-gpio");

var Action = function () {

  this.pins = {front: 22, garden: 16};

  this.defineProperties({
    temp: {type: 'datatime'},
    server_time_epoch: Date.now(),
    last_run_start_time: {type: 'datetime'},
    last_run_end_time: {type: 'datetime'},
    currently_running: {type: 'boolean'},
    garden_on: {type: 'boolean'},
    front_on: {type: 'boolean'},
    auto_shutoff: {type: 'datetime'}
  });


  this.setStatus = function(o){
    console.log("Action.setStatus", o);
    // make updates here
    switch (o.action){
      case 'both_on':
        console.log("BOTH");
        break;
      case 'garden':
        console.log("GARDEN");
        break;
      case 'front':
        console.log("FRONT");
        break;
      case 'off':
        console.log("ALL OFF");
        break;
    }



    return this.getStatus();
  };

  this.getStatus = function(){
    var o = {
      server_time_epoch: Date(),
      last_run_start_time: this.last_run_start_time,
      last_run_end_time: this.last_run_end_time,
      currently_running: this.currently_running,
      garden_on: this.garden_on,
      front_on: this.front_on,
      auto_shutoff: this.auto_shutoff
    };
    console.log("Action.getStatus", o);
    return o;
  };

  /*
  this.property('login', 'string', {required: true});
  this.property('password', 'string', {required: true});
  this.property('lastName', 'string');
  this.property('firstName', 'string');

  this.validatesPresent('login');
  this.validatesFormat('login', /[a-z]+/, {message: 'Subdivisions!'});
  this.validatesLength('login', {min: 3});
  // Use with the name of the other parameter to compare with
  this.validatesConfirmed('password', 'confirmPassword');
  // Use with any function that returns a Boolean
  this.validatesWithFunction('password', function (s) {
      return s.length > 0;
  });

  // Can define methods for instances like this
  this.someMethod = function () {
    // Do some stuff
  };
  */

};

/*
// Can also define them on the prototype
Action.prototype.someOtherMethod = function () {
  // Do some other stuff
};
// Can also define static methods and properties
Action.someStaticMethod = function () {
  // Do some other stuff
};
Action.someStaticProperty = 'YYZ';
*/

exports.Action = Action;

