// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery
//= require bxslider
//= require fancybox
//= require_tree .

$(document).ready(function(){
  $(".fancybox").fancybox({
      openEffect: "none",
      closeEffect: "none"
  });

  $('#slide1').bxSlider({
    minSlides: 3,
    maxSlides: 4,
    slideWidth: 280,
    slideMargin: 10,
    moveSlides: 1,
    auto: true,
    // // auto_hover: true,
    // controls: ture,
  });
  $("#single_picture").iPicture();
  $(".iPictures").iPicture();

  $( "#business_user input[type=checkbox]" ).on( "click", function(event){

    if ($('.input-company-name').hasClass('hidden') && $(this).is(':checked')){
      $('.input-user-name').addClass('hidden');
      $('.input-company-name').removeClass('hidden');
    }else{
      $('.input-user-name').removeClass('hidden');
      $('.input-company-name').addClass('hidden');
    }
  });

  //user.js
  $(function() {
    $('#inputImage').on('change', function(event) {
      $('#signUp').addClass('col-md-6');
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
        $('#previewImage img').css({'max-width': '400px', 'height':'auto'})
        $('#previewImage img').addClass("ip_tooltipImg");
        //AJAX call post request to create a new post and get post id from the server
      }
      reader.readAsDataURL(image);
      console.log(files);
    });

  });

  //post.js
  const outfit_labels = [];
  let x;
  let y;
  let offset;
  $(document).on("click", "#previewImage img", function(e){
  // $('#previewImage img').on("click", function(e){
    $('#newItemFormDiv').removeClass('hidden');
    offset = $(this).offset();
    x = e.pageX - offset.left;
    y = e.pageY - offset.top;

    // debugger;
    //show form div
    $('#newItemForm').off().on('submit', function(event){
      console.log(x);
      console.log(y);
      event.preventDefault();
      const fData = new FormData(event.currentTarget);
      const link = fData.get('link');
      const price = fData.get('price');
      const brand = fData.get('brand');
      const detail = fData.get('detail');
      const kind = fData.get('kind');
      console.log(link);
      console.log(price);
      //debugger;
      outfit_labels.push({
        x: x,
        y: y,
        price: price,
        link: link,
        brand: brand,
        detail: detail,
        kind: kind
      })
      $('#itemPrice').val('');
      $('#itemLink').val('');
      $('#itemBrand').val('');
      $('#item_kind').val('');
      $('#item_detail').val('');
      $('#newItemFormDiv').addClass('hidden');
      $("#previewImage").append(`<div class="ip_tooltip ip_img32" style="top: ${y}px; left: ${x}px;" data-button="moreblue" data-tooltipbg="bgblack" data-round="roundBgW" data-animationtype="ltr-slide">
      <ul><li>${brand}</li><li>${kind}</li><li>$${price}</li><li>${detail}</li><li><a href="${link}">Find item here</a></li></ul></div>`);
      //debugger;
      console.log(outfit_labels);
      $("#iPicture").iPicture();
    })
  });
  //man and woman
  $("#newPostForm").on('submit', function() {
    $(this).find('#items').val(JSON.stringify(outfit_labels));
    outfit_labels = [];
    return true;
  });

});
