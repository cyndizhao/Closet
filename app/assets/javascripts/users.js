// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function(){
  $(function() {
    $('#inputImage').on('change', function(event) {
      var files = event.target.files;
      var image = files[0]
      // here's the file size
      console.log(image.size);
      var reader = new FileReader();
      reader.onload = function(file) {
        var img = new Image();
        console.log(file);
        img.src = file.target.result;
        $('#previewImage').html(img);
        $('#previewImage img').css({'max-width': '300px', 'height':'auto'})
      }
      reader.readAsDataURL(image);
      console.log(files);
    });
  });
});
