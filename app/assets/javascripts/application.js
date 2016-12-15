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
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets


$( document ).ready(function() {
  $( "#user" ).focus();
});

function countChar(val) {
  var len = val.value.length;
  if (len >= 10) {
     $("#submit").focus();
      $("#submit").click();
  } else {
    $('#charNum').text(len);
  }
}

function countMemberId(val) {
  var len = val.value.length;
  if (len >= 9) {
     $("#isbn").focus();
  } else {
    $('#charNum').text(len);
  }
}



$(document).ready(function(){

   $(".view_book").attr('href', function(i, h) {
     return h + (h.indexOf('edit') != -1 ? "?page=2" : "");
   });  

  $(".list_book").click(function(){
    var href_to_go = $(this).children().children().attr('href');
    window.location.href = href_to_go;
  });
});