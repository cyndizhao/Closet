// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function(){
  window.outfit_labels = [];
  $(document).on("click", "#previewImage img", function(e){
    var x = e.pageX - this.offsetLeft;
    var y = e.pageY - this.offsetTop;
    var text = prompt("Outfit Information:");
    outfit_labels.push({
      x: x,
      y: y,
      text: text
    })
  });
  $("#newPostForm").on('submit', function() {
    $(this).find('#labels').val(JSON.stringify(labels));
    return true;
  });
});
