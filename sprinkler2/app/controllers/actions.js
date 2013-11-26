var Actions = function () {
  this.respondsWith = ['html', 'json', 'xml', 'js', 'txt'];

  this.index = function (req, resp, params) {
    var self = this;

    geddy.model.Action.all(function(err, actions) {
      self.respond({params: params, actions: actions});
    });
  };

  this.add = function (req, resp, params) {
    this.respond({params: params});
  };

  this.create = function (req, resp, params) {
    var self = this
      , action = geddy.model.Action.create(params);

    if (!action.isValid()) {
      this.flash.error(action.errors);
      this.redirect({action: 'add'});
    }
    else {
      action.save(function(err, data) {
        if (err) {
          self.flash.error(err);
          self.redirect({action: 'add'});
        }
        else {
          self.redirect({controller: self.name});
        }
      });
    }
  };

  this.show = function (req, resp, params) {
    var self = this;

    geddy.model.Action.first(params.id, function(err, action) {
      if (!action) {
        var err = new Error();
        err.statusCode = 404;
        self.error(err);
      }
      else {
        self.respond({params: params, action: action.toObj()});
      }
    });
  };

  this.edit = function (req, resp, params) {
    var self = this;

    geddy.model.Action.first(params.id, function(err, action) {
      if (!action) {
        var err = new Error();
        err.statusCode = 400;
        self.error(err);
      }
      else {
        self.respond({params: params, action: action});
      }
    });
  };

  this.update = function (req, resp, params) {
    var self = this;

    geddy.model.Action.first(params.id, function(err, action) {
      action.updateProperties(params);
      if (!action.isValid()) {
        this.flash.error(action.errors);
        this.redirect({action: 'edit'});
      }
      else {
        action.save(function(err, data) {
          if (err) {
            self.flash.error(err);
            self.redirect({action: 'edit'});
          }
          else {
            self.redirect({controller: self.name});
          }
        });
      }
    });
  };

  this.destroy = function (req, resp, params) {
    var self = this;

    geddy.model.Action.remove(params.id, function(err) {
      if (err) {
        self.flash.error(err);
        self.redirect({action: 'edit'});
      }
      else {
        self.redirect({controller: self.name});
      }
    });
  };

};

exports.Actions = Actions;
