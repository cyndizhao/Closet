// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function(){
  let outfit_labels = [];
  $(document).on("click", "#previewImage img", function(e){
    var offset = $(this).offset()
    var x = e.pageX - offset.left;
    var y = e.pageY - offset.top;

    var text = prompt("Outfit Information:");
    outfit_labels.push({
      x: x,
      y: y,
      text: text
    })

    // $("#previewImage").append(`<p>${text}</p>`);
    $("#previewImage").append(`<div class="ip_tooltip ip_img32" style="top: ${y}px; left: ${x}px;" data-button="moreblue" data-tooltipbg="bgblack" data-round="roundBgW" data-animationtype="ltr-slide">
        <p>${text}</p>
    </div>`);
    $("#iPicture").iPicture();


  });
  $("#newPostForm").on('submit', function() {
    $(this).find('#labels').val(JSON.stringify(outfit_labels));
    outfit_labels = [];
    return true;
  });
});
