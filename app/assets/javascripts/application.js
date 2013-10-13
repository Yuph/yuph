// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .

function PreviewImage() {
    var oFReader = new FileReader();
    oFReader.readAsDataURL(document.getElementById("uploadImage").files[0]);
    oFReader.onload = function (oFREvent) {
        document.getElementById("uploadPreview").src = oFREvent.target.result;
    };
};
$.rails.confirm = function(message, element) 
{ 
    var state = element.data('state');
    var txt = element.text();
    if (!state)
    {
$(document.createElement('div'))
        .html(message)
        .dialog({
            draggable: false,
            modal: true,
            resizable: false,
            height: '100',
            dialogClass: 'alert-dialog',
            buttons: [
                {
                  text: "Sim",
                  click: function() {
                    $( this ).dialog( "close" );
                    return true;
                  }
                }
              ]
        });
        return false;
    }   
    else
    {
        return true;
    }
};
 
$.rails.allowAction = function(element) 
{
    var message = element.data('confirm'),
        answer = false, callback;
    if (!message) { return true; }
 
    if ($.rails.fire(element, 'confirm')) 
    {
        // le extension.
        answer = $.rails.confirm(message, element);
        callback = $.rails.fire(element, 'confirm:complete', [answer]);
    }
    return answer && callback;
};
 
$.rails.handleLink = function(link) 
{
    if (link.data('remote') !== undefined) 
    {
        $.rails.handleRemote(link);
    } 
    else if (link.data('method')) 
    {
        $.rails.handleMethod(link);
    }
 
    return false;
};