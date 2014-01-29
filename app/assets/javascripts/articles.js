$(document).ready(function(){

  // Append new comment to the list upon AJAX success
  $('.new_comment').on('ajax:success', function(e, comment) {
    var commentId = comment.id;
    var listItem = $('<li/>').addClass('comment').attr('id', 'comment_' + commentId).text(comment.content);
    $('ul.comments').append(listItem);
    $('input#comment_content').val('');
  });
  
});