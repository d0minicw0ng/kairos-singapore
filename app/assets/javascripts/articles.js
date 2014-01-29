$(document).ready(function(){

  // Append new comment to the list upon AJAX success
  $('.new_comment').on('ajax:success', function(e, comment) {
    var listItem = HandlebarsTemplates['comments/show']({ comment: comment });
    $('ul.comments').append(listItem);
    $('input#comment_content').val('');
  });

});