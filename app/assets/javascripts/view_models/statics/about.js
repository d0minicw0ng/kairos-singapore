function ContactUsViewModel() {
    var self = this;
    self.subject = ko.observable()
    self.message = ko.observable()

    self.sendMessage = function() {
        $.post('/contact_us', {subject: self.subject(), message: self.message()}, function() {
            $('#contact-us #subject').val('');
            $('#contact-us #message').val('');
            $('div#contact-us .container').prepend('<div class="alert alert-success">Your message has been sent! We will be in contact soon.</div>');
            setTimeout(function() {
                $('div.alert-success').remove();
            }, 5000);
        })
    }
}
