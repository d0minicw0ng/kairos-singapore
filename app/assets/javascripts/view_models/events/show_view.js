function EventShowViewModel(data) {
    var self = this;

    new EventMapViewModel(data.latitude, data.longitude);
    new ProjectRegisterEventViewModel();
}


function UserRegisterEventViewModel() {
    var self = this;
    self.currentUserId = $('.user-register-event').data('current-user-id');
    self.eventId = $('.user-register-event').data('event-id');
    self.postData = { user_event_registration: {user_id: self.currentUserId, event_id: self.eventId}}

    if (parseInt($('.user-unregister-event').data('id')) == 0){
        $('.user-unregister-event').hide();
    } else {
        $('.user-register-event').hide();
    }

    self.register = function() {
        $.post('/user_event_registrations',
               self.postData,
               function(data) {
                   $('.user-register-event').hide();
                   $('.user-unregister-event').data('id', data.id);
                   $('.user-unregister-event').show()
               }
        );
    }

    self.unregister = function() {
        $.ajax({
            url: '/user_event_registrations/' + $('.user-unregister-event').data('id'),
            type: 'DELETE',
            dataType: 'json',
            success: function(data, event) {
                $('.user-unregister-event').data('id', 0)
                $('.user-unregister-event').hide();
                $('.user-register-event').show();
            }
        });
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
