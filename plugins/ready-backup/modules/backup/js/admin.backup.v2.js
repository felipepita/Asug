jQuery(document).ready(function() {
	var j = jQuery.noConflict();
	
	// Toggle 'Send to'
	j('.bupSendTo').on('click', function() {
		j(this).parent().next().toggle();
	});
	
	// Download
	j('.bupDownload').on('click', function() {
		var filename = j(this).attr('data-filename');
		
		BackupModule.download(filename);
	});
	
	// Delete
	j('.bupDelete').on('click', function() {
		var filename = j(this).attr('data-filename'),
			id       = j(this).attr('data-id');
			
		if (confirm('Are you sure?')) {
			BackupModule.remove(id, filename, this);
		}
	});
	
	// Restore
	j('.bupRestore').on('click', function() {
		var filename = j(this).attr('data-filename'),
			id       = j(this).attr('data-id');
			
		BackupModule.restore(id, filename);
	});
	
	// Create
	j('#bupAdminMainForm').submit(function(event) {
		event.preventDefault();
		BackupModule.create(this);
	});
	
	jQuery('.bupSendToBtn').on('click', function(clickEvent) {
		clickEvent.preventDefault();
		var providerModule = jQuery(this).attr('data-provider'),
			providerAction = jQuery(this).attr('data-action'),
			files          = jQuery(this).attr('data-files'),
			id             = jQuery(this).attr('id');

		console.log('Module: ' + providerModule);
		console.log('Action: ' + providerAction);
		console.log('Files: '  + files);
		BackupModule.upload(providerModule, providerAction, files, id);

	});
});

/**
 * Backup Module
 */
var BackupModule = {
	download: function(filename) {
		document.location.href = document.location.href + '&download=' + filename;
	},
	remove: function(id, filename, button) {
		jQuery.sendFormBup({
			msgElID: 'MSG_EL_ID_' + id,
			data: {
				'reqType':  'ajax',
				'page':     'backup',
				'action':   'removeAction',
				'filename': filename
			},
			onSuccess: function(response) {
				if (response.error === false) {
					jQuery(button).parent().parent().remove();
				}
			}
		});
	},
	restore: function(id, filename) {
		jQuery.sendFormBup({
			msgElID: 'MSG_EL_ID_' + id,
			data: {
				'reqType':  'ajax',
				'page':     'backup',
				'action':   'restoreAction',
				'filename': filename
			},
			onSuccess: function(response) {
				console.log(response);
				if (response.error === false) {
					location.reload(true);
				}
			}
		});
	},
	create: function(form) {
		
		var progress = jQuery('.main-progress-bar');

        jQuery('.' + progress.attr('class') + ' .progress-bar span').css({ width: '1%' });
		progress.show();
		
		jQuery(form).sendFormBup({
			msgElID: 'BUP_MESS_MAIN',
			onSuccess: function(response) {

                if (response.data.length === 0) {
                    progress.hide();
                    return;
                }

                var files = response.data.files,
                    perStack = response.data.per_stack,
                    stacks = bupGetFilesStacks(files, perStack),
                    total = stacks.length, i = 0;

                jQuery.each(stacks, function(index, stack) {
                    bupGetTemporaryArchive(stack, progress, function() {

                        var span = jQuery('.progress-bar').find('span'),
                            width = jQuery.trim(parseFloat(jQuery(span[0]).attr('style').split(':')[1])), // :D
                            current, percent;

                        i++;

                        percent = (i / total) * 100;

                        console.log('Stack ' + i + ' of ' + total);
                        console.log('Complete: ' + percent + '%');
                        jQuery('#BUP_MESS_MAIN').addClass('bupSuccessMsg').text('Please wait while the plugin gather information  (' + Math.round(percent) + '%)');

                        jQuery(span[0]).css({ width: percent + '%' });

                        if (percent === 100) {
                            setTimeout(function() {
                                sendCompleteRequest(progress);
                                jQuery('#BUP_MESS_MAIN').addClass('bupSuccessMsg').text('Processing file stacks, please wait. It may take some time (depending on the number and size of files)');
                            }, 1000);
                        }
                    });
                });
			}
		});
	},
	upload: function(providerModule, providerAction, files, identifier) {
		jQuery.sendFormBup({
			msgElID: 'MSG_EL_ID_' + identifier,
			data: {
				page:    providerModule, // Module
				action:  providerAction, // Action
				reqType: 'ajax',         // Request type
				sendArr: files           // Files
			}
		});
	}
};

function bupGetFilesStacks(files, num) {
    var stack = [],
        parts = Math.ceil(files.length / num);

    for(var i = 0; i < parts; i++) {
        stack.push(bupGetStack(files, num));
    }

    return stack;
}

function bupGetStack(files, num) {

    var stack = [];

    if (files.length < num) {
        num = files.length;
    }

    for(var j = 0; j < num; j++) {
        stack.push(files.pop());
    }

    return stack;
}

function bupGetTemporaryArchive(files, progress, cb) {
    jQuery.sendFormBup({
        data: {
            reqType:  'ajax',
            page:     'backup',
            action:   'createStackAction',
            files:    files
        },
        onSuccess: function(response) {

            cb();

            if (response.error === false) {
                jQuery.sendFormBup({
                    data: {
                        reqType:  'ajax',
                        page:     'backup',
                        action:   'writeTmpDbAction',
                        tmp:      response.data.filename
                    }
                });
            } else {
                progress.hide(function() {
                    console.log('ERROR');
                    console.log(response);
//                    jQuery('#BUP_MESS_MAIN').text(response.errors.join('<br>'));
                });
            }
        }
    });
}

function sendCompleteRequest(progress) {
    jQuery.sendFormBup({
        msgElID: 'BUP_MESS_MAIN',
        data: {
            reqType:  'ajax',
            page:     'backup',
            action:   'createAction',
            complete: true
        },
        onSuccess: function(r) {
            progress.hide();
            console.log(r);
        }
    });
}