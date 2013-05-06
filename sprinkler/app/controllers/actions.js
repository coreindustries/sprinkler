var Actions = function () {
  this.respondsWith = ['html', 'json', 'xml', 'js', 'txt'];

  this.index = function (req, resp, params) {

    this.respond({params: params});
  };

  this.on = function (req, resp, params){
    geddy.log.debug("ON CONTROLLER");
    this.respond({params: params});
  }

  this.add = function (req, resp, params) {
    this.respond({params: params});
  };

  this.create = function (req, resp, params) {
    // Save the resource, then display index page
    this.redirect({controller: this.name});
  };

  this.show = function (req, resp, params) {
    geddy.log.debug(this.name+" CONTROLLER : "+params.id);
    // geddy.log.debug(params);
    if(params.id == "both"){
      geddy.log.debug("**BOTH");
    }
    if(params.id == "front"){
      geddy.log.debug("*FRONT");
    }
    this.respond({params: params});
  };

  this.edit = function (req, resp, params) {
    this.respond({params: params});
  };

  this.update = function (req, resp, params) {
    // Save the resource, then display the item page
    this.redirect({controller: this.name, id: params.id});
  };

  this.destroy = function (req, resp, params) {
    this.respond({params: params});
  };

};

exports.Actions = Actions;

