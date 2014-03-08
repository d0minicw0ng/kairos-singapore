function ContactUsViewModel() {
    var self = this;
    self.subject = ko.observable()
    self.message = ko.observable()

    self.sendMessage = function() {
        $.post('/contact_us', {subject: self.subject(), message: self.message()}, function() {
            $('#contact-us #subject').val('');
            $('#contact-us #message').val('');
            $('#notification').append('<div class="alert alert-success">Your message has been sent! We will be in contact soon.</div>');
            $('html,body').animate({scrollTop:0},0);
            clearNotification();
        })
    }
}
