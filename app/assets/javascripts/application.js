// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require trix
//  require turbolinks
//= require_tree .

$(document).ready( function() {
    $(document).on('change', '.btn-file :file', function() {
        var input = $(this),
            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        input.trigger('fileselect', [label]);
    });

    $('.btn-file :file').on('fileselect', function(event, label) {

        var input = $(this).parents('.input-group').find(':text'),
            log = label;

        if( input.length ) {
            input.val(log);
        } else {
            if( log ) alert(log);
        }

    });
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#img-upload').attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    $(document).on("change", "#imgInp", function(){
        readURL(this);
    });

    var show_text_fn = function (){
        $("div#block_image").hide();
        $("div#block_video").hide();
        $("div#block_text").show();
    };
    var show_image_fn = function (){
        $("div#block_text").hide();
        $("div#block_video").hide();
        $("div#block_image").show();
    };
    var show_video_fn = function (){
        $("div#block_text").hide();
        $("div#block_image").hide();
        $("div#block_video").show();
    };

    $("div#block_text").hide();
    $("div#block_image").hide();
    $("div#block_video").hide();

    if ($("select#block_block_type").val() == "text"){
        show_text_fn();
    }else if ($("select#block_block_type").val() == "image"){
        show_image_fn();
    }else if ($("select#block_block_type").val() == "video"){
        show_video_fn();
    }

    $("select#block_block_type").change(function() {
        if ($(this).val() == "text"){
            show_text_fn();
        }
        if ($(this).val() == "image"){
            show_image_fn()
        }
        if ($(this).val() == "video"){
            show_video_fn()
        }
    });
});








