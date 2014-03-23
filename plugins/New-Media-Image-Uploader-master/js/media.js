jQuery(document).ready(function() {
 
var formfield = "";
    jQuery('.browse_upload').click(function() {
            formfield = jQuery(this).attr('name');
            tb_show('', 'media-upload.php?type=image&TB_iframe=true');

            return false;
    });
    window.send_to_editor = function(html) {
            hrefurl = jQuery('img',html).attr('src');
            if(jQuery(hrefurl).length == 0) {
                hrefurl = jQuery(html).attr('href'); // We do this to get Links like PDF's
            }
            jQuery('#user_meta_image').val(hrefurl);
            tb_remove();

    }
 
});