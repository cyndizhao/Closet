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
//= require bxslider
//= require chosen-jquery
//= require underscore
//= require gmaps/google
//= require_tree .

$(document).ready(function(){

  //home page slider
  $('#slide1, #slide2, #slide3').bxSlider({
    minSlides: 2,
    maxSlides: 4,
    slideWidth: 280,
    slideMargin: 10,
    moveSlides: 1,
    auto: true,
    // controls: ture,
  });

  $('.chosen-select').chosen();

  //user.js signup form
  $( "#business_user input[type=checkbox]" ).on( "click", function(event){

    if ($('.input-company-name').hasClass('hidden') && $(this).is(':checked')){
      $('.input-user-name').addClass('hidden');
      $('.input-company-name').removeClass('hidden');
    }else{
      $('.input-user-name').removeClass('hidden');
      $('.input-company-name').addClass('hidden');
    }
  });

  //create user selfie; user.js
  $(function() {
    $('#inputPicture, #inputImage').on('change', function(event) {
      $('#signUp').addClass('col-md-6');

      var files = event.target.files;
      var image = files[0]
      // here's the file size
      // console.log(image.size);
      var reader = new FileReader();
      reader.onload = function(file) {
        var img = new Image();
        // console.log(file);
        img.src = file.target.result;
        $('#previewImage').html(img);
        $('#previewImage img').css({'max-width': '400px', 'max-height':'400px'})
        $('#previewImage img').addClass("ip_tooltipImg");

        $('#new-post-div, #message1').removeClass('hidden');
      }
      reader.readAsDataURL(image);
      console.log(files);
    });

  });

  //Create new post and associated items; post.js
  const outfit_labels = [];
  let x;
  let y;
  let offset;
  $(document).on("click", "#previewImage img", function(e){
    $('#newItemFormDiv, #message2').removeClass('hidden');
    offset = $(this).offset();
    x = e.pageX - offset.left;
    y = e.pageY - offset.top;

    //show item form div
    $('#newItemForm').off().on('submit', function(event){
      event.preventDefault();
      const fData = new FormData(event.currentTarget);
      const link = fData.get('link');
      const price = fData.get('price');
      const brand = fData.get('brand');
      const detail = fData.get('detail');
      const kind = fData.get('kind');

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
      $('#newItemFormDiv, #message2').addClass('hidden');
      $("#previewImage").append(`<div class="ip_tooltip ip_img32" style="top:
      ${y}px; left: ${x}px;" data-button="moreblue" data-tooltipbg="bgblack"
      data-round="roundBgW" data-animationtype="ltr-slide">
      <ul><li>${brand}</li><li>${kind}</li><li>$${price}</li><li>${detail}</li>
      <li><a href="${link}">Find item here</a></li></ul></div>`);

      console.log(outfit_labels);
      $("#iPicture").iPicture();
    })
  });

  $("#newPostForm").on('submit', function() {
    $(this).find('#items').val(JSON.stringify(outfit_labels));
    $('#message').addClass('hidden');
    outfit_labels = [];
    return true;
  });


  let map;
  let pyrmont;
  let centerImage = {
    url: 'http://www.myiconfinder.com/uploads/iconsets/256-256-a5485b563efc4511e0cd8bd04ad0fe9e.png',
    scaledSize: new google.maps.Size(35, 35),
  }
  //find closest store GOOGLE MAP
  $('#get_location').on('click', function(event){
    event.preventDefault();
    if($('#map_wrapper').hasClass('hidden')){
      // $('.map_spinner').show();
      if (pyrmont){
        $('#map_wrapper').removeClass('hidden');
        centerMap(pyrmont);
      }
      navigator.geolocation.getCurrentPosition(function(location) {
        const lat = location.coords.latitude;
        const log = location.coords.longitude;
        pyrmont = new google.maps.LatLng(lat,log);
        // Test when user change IP address, map center changes
        // pyrmont = new google.maps.LatLng(49 + Math.random(), -123 - Math.random());

        centerMap(pyrmont);
        $('#map_wrapper').removeClass('hidden');

        const query = $('#map').attr("data-id");
        const request = {
          location: pyrmont,
          radius: '1000',
          query: query
        };
        service = new google.maps.places.PlacesService(map);
        service.textSearch(request, callback);
      });

    }else{
      $('#map_wrapper').addClass('hidden');
    }

    function centerMap(pyrmont){
      map = map || new google.maps.Map(document.getElementById('map'), {
        center: pyrmont,
        zoom: 15
      });
      map.setCenter(pyrmont);
      var centerMarker = new google.maps.Marker({
        position: pyrmont,
        title: 'Your Current Position',
        map: map,
        icon: centerImage
      });
    }

    function callback(results, status) {
      if (status == google.maps.places.PlacesServiceStatus.OK) {
        for (var i = 0; i < results.length; i++) {
          createMarker(results[i]);
        }
      }
      // $('.map_spinner').hide();
    }
    function createMarker(place) {
      var placeLoc = place.geometry.location;
      var marker = new google.maps.Marker({
        map: map,
        title: place.name,
        position: place.geometry.location
      });
    }


  });
  $(".iPictures").iPicture();
});
