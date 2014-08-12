//FIXME: Holy shit, `this` is window, fix it!
function UserSearchViewModel() {
  var self = this;
  self.allUsers = ko.observableArray();
  self.skillList = ko.observableArray();
  self.filters = ko.observableArray([]);
  self.users = ko.computed(function() {
    if ((self.filters() && self.filters().length == 0) ||
         !self.filters()) {
      return self.allUsers();
    }

    return _.filter(self.allUsers(), function(user) {
      diff = _.difference(user.skills, self.filters());

      if (user.skills.length > diff.length) {
        return true;
      }
      return false;
    });
  });

  self.load = function() {
    self.loadUsers();
    self.loadSkills();
  }

  self.loadUsers = function() {
    self.allUsers([]);

    $.get('/api/users/', function(users, status) {
      for (var i = 0; i < users.length; i++) {
        userVM = new UserViewModel(users[i]);
        self.allUsers.push(userVM);
      }
      return;
    });
  }

  self.loadSkills = function() {
    self.skillList([]);

    $.get('/api/tags/skills', function(skills, status) {
      for (var i = 0; i < skills.length; i++) {
        skillVM = new SkillViewModel(skills[i]);
        self.skillList.push(skillVM);
      }
      return;
    });
  }

  self.load();
};

function UserViewModel(user) {
  this.user = user;
  this.skills = user.skill_list;
  this.url = "/users/" + user.username;
  this.imageURL = user.avatar_url;

  var displayName;

  if (user.first_name && user.last_name) {
    displayName = user.first_name + " " + user.last_name;
  } else {
    displayName = user.username;
  }

  this.displayName = displayName;
}

function SkillViewModel(skill) {
  this.name = skill.name;
}
