$(document).ready(function(){
  $('.new_comment').on('ajax:success', function(e, data) {
    console.log(e);
    console.log(data);
    alert('Comment Left')
  });
});