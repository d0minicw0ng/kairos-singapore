function UserSearchViewModel() {
  var self = this;
  self.allUsers = ko.observableArray();
  self.skillList = ko.observableArray();
  self.filters = ko.observableArray();
  self.users = ko.computed(function() {
    return _.filter(self.allUsers(), function(user) {
      var match;
      match = _.intersection(user.skills, self.filters());
      return match.length === user.skills.length;
    });
  });

  self.load = function() {
    self.loadUsers();
    self.loadSkills();
  }

  self.loadUsers = function() {
    $.get('/api/users/', function(data, status) {
      console.log("users", data);
      return;
    });
  }

  self.loadSkills = function() {
    $.get('/api/tags/skills', function(data, status) {
      console.log("skills", data);
      return;
    });
  }

  self.load()
};

