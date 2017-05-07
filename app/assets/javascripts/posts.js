// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

// $(document).ready(function(){
//   const outfit_labels = [];
//   let x;
//   let y;
//   let offset;
//   $(document).on("click", "#previewImage img", function(e){
//   // $('#previewImage img').on("click", function(e){
//     $('#newItemFormDiv').removeClass('hidden');
//     offset = $(this).offset();
//     x = e.pageX - offset.left;
//     y = e.pageY - offset.top;
//     debugger;
//     //show form div
//     $('#newItemForm').on('submit', function(event){
//       console.log(x);
//       console.log(y);
//       event.preventDefault();
//       const fData = new FormData(event.currentTarget);
//       const link = fData.get('link');
//       const price = fData.get('price');
//       console.log(link);
//       console.log(price);
//       debugger;
//       outfit_labels.push({
//         x: x,
//         y: y,
//         price: price,
//         link: link
//       })
//       $('#itemPrice').val('');
//       $('#itemLink').val('');
//       $('#newItemFormDiv').addClass('hidden');
//
//       $("#previewImage").append(`<div class="ip_tooltip ip_img32" style="top: ${y}px; left: ${x}px;" data-button="moreblue" data-tooltipbg="bgblack" data-round="roundBgW" data-animationtype="ltr-slide">
//       <p>$${price}</p><p>${link}</p></div>`);
//       debugger;
//       $("#iPicture").iPicture();
//       console.log(outfit_labels);
//     })
//
//   });
//
//   //how to store the outfit_labels information in the database table Post description on submit
//   //man and woman
//   $("#newPostForm").on('submit', function() {
//     $(this).find('#items').val(JSON.stringify(outfit_labels));
//     outfit_labels = [];
//     return true;
//   });
// });
