function ProjectVideoViewModel() {
    self = this;
    $('.player').mb_YTPlayer();

    self.play = function() {
        $('#bgndVideo').playYTP();
    }

    self.pause = function() {
        $('#bgndVideo').pauseYTP();
    }

    self.mute = function() {
        $('#bgndVideo').muteYTPVolume();
    }

    self.unmute = function() {
        $('#bgndVideo').unmuteYTPVolume();
    }
}
