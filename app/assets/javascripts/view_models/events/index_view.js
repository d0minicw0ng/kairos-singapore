function UserRegisterEventViewModel(data) {
    var self = this;
}

function ProjectRegisterEventViewModel() {
    var self = this;
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
