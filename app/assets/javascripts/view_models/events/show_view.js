function EventShowViewModel(data) {
    var self = this;
    self.currentUserId = data.currentUserId;
    self.eventId = data.eventId;

    new EventMapViewModel(data.latitude, data.longitude);
    new ProjectRegisterEventViewModel();
    new UserRegisterEventViewModel(self.currentUserId, self.eventId);
}


function UserRegisterEventViewModel(currentUserId, eventId) {
    var self = this;
    //FIXME: There must be some parsing error that screws up the json data. 
    self.postData = ko.toJSON({ user_event_registration: {user_id: currentUserId, event_id: eventId}});
    self.currentUserId = currentUserId;
    self.eventId = eventId;

    self.register = function() {
        $.post('/user_event_registrations',
               self.postData,
               function(data) {
                   $('.user-register-event').remove();
                   var unRegister = $("<a href='#' class='btn btn-warning user-unregister-event' data-remote='true' data-id=" + data.id + ">Unregister Event</a>");
                   $('.user-event').prepend(unRegister);
               });


       //  $.ajax({
       //      url: '/user_event_registrations',
       //      type: 'POST',
       //      data: {user_event_registration: {user_id: self.currentUserId, event_id: eventId}},
       //      dataType: 'json',
       //      success: function(data) {
       //          $('.user-register-event').remove();
       //          var unRegister = $("<a href='#' class='btn btn-warning user-unregister-event' data-remote='true' data-id=" + data.id + ">Unregister Event</a>");
       //          $('.user-event').prepend(unRegister);
       //      }
       //  });
    }
}


function ProjectRegisterEventViewModel() {
    var self = this;

    self.showSelectProjectForm = function() {
        $('#select-project-form').toggle();
    }
}


function UserVoteViewModel() {
    var self = this;
}


function EventMapViewModel(latitude, longitude) {
    handler = Gmaps.build('Google');
    handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        markers = handler.addMarkers([
            {
                "lat": latitude,
                "lng": longitude,
                "picture": {
                    "url": "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png",
                    "width":  36,
                    "height": 36
                },
                "infowindow":'hello'
            }
        ]);
        handler.bounds.extendWith(markers);
        handler.fitMapToBounds();
    });
}
