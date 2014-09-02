function RegistrationFormViewModel() {
    var self = this;

    self.showInterviewQuestions = function( ){

      $("button#go-to-interview-questions").hide();
      $("button#back-to-basic-information").show();
      $("#basic-information").hide();

      $("#interview-questions").show();
      $("#submit-application-form").show();

      $("h2#registration-form-title").text("Tell Us More About Yourself.");
      window.scrollTo(0, 0);
    }

    self.showBasicInformation = function( ){

      $("button#go-to-interview-questions").show();
      $("button#back-to-basic-information").hide();
      $("#basic-information").show();

      $("#interview-questions").hide();
      $("#submit-application-form").hide();

      $("h2#registration-form-title").text("Sign up");
      window.scrollTo(0, 0);
    }

}
