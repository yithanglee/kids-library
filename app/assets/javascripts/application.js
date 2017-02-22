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
//= require bootstrap-sprockets
//= require_tree .

var $user_type;

$(document).ready(function() {
  $( "#book" ).focus();
  $("#flash").delay(10000).fadeOut('slow');

$('#agree').click(function(){
$('div#registration-form').show()
$('div#library-rules').hide()
})

  $("select#user_user_type").change(function(){
     $user_type = $(this).val();
     console.log($user_type);
  	if ($user_type == 'parents') {
    	$('#my-kids').html('My Kad number')
    	$('#parents-group').hide();
		};
		  	if ($user_type == 'children') {
    	$('#my-kids').html('My Kid number')
    	$('#parents-group').show();
		};

  });


});

