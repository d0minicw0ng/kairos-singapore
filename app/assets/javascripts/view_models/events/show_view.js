//FIXME: You need to add/remove user/project to the registered users/events sections on success callback
function UserRegisterEventViewModel() {
    var self = this;
    self.postData = {
        user_event_registration: {
            user_id: $('.user-register-event').data('user-id'),
            event_id:  $('.user-register-event').data('event-id')
        }
    }

    self.noUserRegisteredEvent = function(){
        return parseInt($('.user-unregister-event').data('id')) == 0;
    }

    self.registerUser = function() {
        $.post('/user_event_registrations',
               self.postData,
               function(data) {
                   $('.user-register-event').hide();
                   $('.user-unregister-event').data('id', data.id);
                   $('.user-unregister-event').show();
                   var message = HandlebarsTemplates['alerts/success']({
                     message: 'You have registered for the event!'
                   })
                   $('#notification').append(message);
                   clearNotification();
               }
        );
    }

    self.unregisterUser = function() {
        $.ajax({
            url: '/user_event_registrations/' + $('.user-unregister-event').data('id'),
            type: 'DELETE',
            dataType: 'json',
            success: function(data, event) {
                $('.user-unregister-event').data('id', 0)
                $('.user-unregister-event').hide();
                $('.user-register-event').show();
                var message = HandlebarsTemplates['alerts/danger']({
                  message: 'You have uregistered for the event!'
                });
                $('#notification').append(message);
                clearNotification();
            }
        });
    }
}


function ProjectRegisterEventViewModel() {
    var self = this;

    self.noProjectRegisteredEvent = function(){
        return parseInt($('.project-unregister-event').data('id')) == 0;
    }

    self.showSelectProjectForm = function() {
        $('#select-project-form').toggle();
    }

    self.unregisterProject = function() {
        var regId = $('.project-unregister-event').data('id');
        $.ajax({
            url: '/project_event_registrations/' + regId,
            type: 'DELETE',
            dataType: 'json',
            success: function(data) {
                $('.project-unregister-event').data('id', 0);
                $('.project-unregister-event').hide();
                $('.project-register-event').show();
                var message = HandlebarsTemplates['alerts/danger']({
                  message: 'Your startup has unregistered for the event!'
                });
                $('#notification').append(message);
                clearNotification();
            }
        });
    }

    //FIXME: Project register for event (it should not be done this way, obviously, but
    // when I move this block nested under the project register event div, it breaks the CSS.
    // Given how 'genius' I am in CSS, I would rather make this look ugly for now until I figure
    // a way to make the form look nice. Thanks :) )
    $('div.register').on('click', '.project-register-event-final', function(event) {
        event.preventDefault();
        var projectId = $('#project-event-select option:selected').val();
        $.ajax({
            url: '/project_event_registrations',
            type: 'POST',
            data: {project_event_registration: {project_id: projectId, event_id: $('.project-register-event-final').data('event-id')}},
            dataType: 'json',
            success: function(data) {
                $('.project-register-event').hide();
                $('.project-unregister-event').data('id', data.id);
                $('.project-unregister-event').show();
                $('#select-project-form').hide();
                var message = HandlebarsTemplates['alerts/success']({
                  message: 'Your startup has registered for the event!'
                });
                $('#notification').append(message);
                clearNotification();
            }
        });
    });
}


function EventMapViewModel(latitude, longitude) {
    handler = Gmaps.build('Google');

    var lat, lng;
    lat = $('#event-map').data('latitude');
    lng = $('#event-map').data('longitude');

    if (lat && lng) {
        handler.buildMap({ provider: {}, internal: {id: 'event-map'}}, function(){
            markers = handler.addMarkers([
                {
                    "lat": lat,
                    "lng": lng,
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
    } else {
        //FIXME: kinda shady, but it works for now.
        $('#event-map').css('height', '100px');
    }
}
