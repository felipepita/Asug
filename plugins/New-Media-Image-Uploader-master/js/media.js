jQuery(document).ready(function() {

jQuery('#upload_image_button').click(function() {
formfield = jQuery('#upload_image').attr('name');
tb_show('', 'media-upload.php?type=image&amp;TB_iframe=true');
return false;
});

jQuery('#upload_pdf_button').click(function() {
formfield = jQuery('#user_meta_image').attr('name');
tb_show('', 'media-upload.php?type=file&amp;TB_iframe=true');
return false;
});

window.send_to_editor = function(html) {
imgurl = jQuery(html).attr('href');
jQuery('#'+formfield).val(imgurl);
tb_remove();
}

});

//CONDICAO SOMENTE BOLETO