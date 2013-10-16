$(document).ready(function(){
	$('.new_idea').validate({
		onfocusout: false,
		focusInvalid: false,
				// hide default label.error
                invalidHandler: function(form, validator) {
                    var errors = validator.numberOfInvalids();
                    if (errors) {
                        alert(validator.errorList[0].message);
                    }
                },
		rules: {
		},
		messages:{
		},
		errorPlacement: $.noop
	});

});
