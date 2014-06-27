<!-- Latest compiled and minified CSS & JS -->
<?php
    $id_users = $_POST['id_users'];


            ?>
<?php 


    global $wpdb;


    $resultado_users = $wpdb->get_results("SELECT * FROM wp_cadastro_eventos WHERE id = $id_users");

    foreach ( $resultado_users as $dados ){
        $novoStatusAtt = $dados->status;
    }

    if ($novoStatusAtt == 1) {
        $novo_status = 0;
        $classeBTN = "btn statusI glyphicon glyphicon-remove btn-danger";
    }
    if ($novoStatusAtt == 0) {
        $novo_status = 1;
        $classeBTN = "btn statusI glyphicon glyphicon-ok btn-success";
    }






        $ativar = $wpdb->query("UPDATE wp_cadastro_eventos SET status = $novo_status WHERE id = $id_users");
        if($ativar) {
            ?>

<script>
    $("#<?php echo $id_users; ?>").removeClass();
    $("#<?php echo $id_users; ?>").addClass("<?php echo $classeBTN; ?>");
</script>

                <?php 
                 exit();
        }








?>
<script>
   jQuery(document).ready( function( $ ) {

    $('#upload_image_button').click(function() {

        formfield = $('#upload_image').attr('name');
        tb_show( '', 'media-upload.php?type=file&amp;TB_iframe=true' );
        return false;
    });

    window.send_to_editor = function(html) {

        imgurl = $('img',html).attr('src');
        $('#upload_image').val(imgurl);
        tb_remove();
    }



});

</script>
<?php 
$id_categoria1 = "22";
$id_categoria2 = "23";
$id_categoria3 = "16";
        ?>
<script type="text/javascript">

jQuery(document).ready(function($) {
    $('.ativo').hide();

    $('.BTinativos').click(function (event) {
        $('.btn-group a').removeClass( 'active' );
        $('.ativo').hide();
        $('.inativo').fadeIn('slow');
        $(this).addClass('active');
    });
    $('.BTativos').click(function (event) {
        $('.btn-group a' ).removeClass( 'active' );
        $('.inativo').hide();
        $('.ativo').fadeIn('slow');
        $(this).addClass('active');
    });
    $('.BTtodos').click(function (event) {
        $('.btn-group a').removeClass( 'active' );
        $('.inativo').fadeIn('slow');
        $('.ativo').fadeIn('slow');
        $(this).addClass('active');
    });
});



    function mudarStatus(id_users){
        var classID = "#"+id_users;

    $(classID).removeClass();
    $(classID).addClass("btn btn-defaul glyphicon glyphicon-transfer");

         jQuery.ajax({
            url: "admin.php?page=lista-de-incritos",
            data: { 'id_users': id_users },
            type: "POST",
            success: function (html) {

                $('body').append(html);
            }
                });
    }

    

</script>

<script type="text/javascript">
    //tb_show('', 'media-upload.php?TB_iframe=true');
    var upload_image_button=false;
    jQuery(document).ready(function() {

    jQuery('.upload_pdf_button').click(function() {
        upload_image_button =true;
        formfieldID=jQuery(this).prev().attr("id");
     formfield = jQuery("#"+formfieldID).attr('name');
     tb_show('', 'media-upload.php?type=file&amp;TB_iframe=true');
        if(upload_image_button==true){

                var oldFunc = window.send_to_editor;
                window.send_to_editor = function(html) {

                imgurl = jQuery(html).attr('href');
                jQuery("#"+formfieldID).val(imgurl);
                 tb_remove();
                window.send_to_editor = oldFunc;
                }
        }
        upload_image_button=false;
    });


    })

</script>

<script type="text/javascript">
$(document).ready(function() {
    $('.SalvarBoleto').click(function(){
        var QtdeBoleto = 0;

        var id_user = new Array();
        var boleto = new Array();
        var id_user_t;
        var boleto_t;
        $('input[class^="upload_pdf_button"]').each(function() {
            if ($(this).val() != "") {
                var tratamento;

                var id_user = $(this).attr('id').split('_')[2];

                if ((id_user_t)||(boleto_t)){
                    id_user_t += id_user + ",";
                    boleto_t += $(this).val() + ",";
                } else{
                    id_user_t = id_user + ",";
                    boleto_t = $(this).val() + ",";
                }


/*
                tratamento = "Valor: " + $(this).val();
                tratamento += " | ID: " + $(this).attr('id');
                tratamento += " | NOME: " + $(this).attr('name');
                tratamento += " | ID usuario: " + id_user;
                alert(tratamento);
*/
                QtdeBoleto++;

            }
        })
         if (QtdeBoleto <= 0) {
                alert('Nenhum boleto inserido');
            }

        if (QtdeBoleto >= 1) {



        $.ajax({
            type: "POST",
            url: '../wp-content/plugins/inscricao-de-eventos/cadastrar_boleto.php',
            data: { id_user_input: id_user_t, boleto_input: boleto_t },
            success: function(res){
                alert(res);
            }
        })










        }
    });
});
</script>

<link rel="stylesheet" media="screen" href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>

<style rel="stylesheet">
    .pqnaTable .inativo, .pqnaTable .ativo{
    font-size: 12px !important;
}
.upload_pdf_button:first-child{
    width: 144px;
    height: 30px;
    float: left;
    border-radius: 6px;
    margin-right: 2px;
}

</style>
<div class="wrap">
    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th><?php echo get_cat_name($id_categoria1);?></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
<table class="table table-hover">
    <tbody>
        <tr>
            <td><b>Evento</b></td>
            <td><b>Qtde de inscritos</b></td>
            <td><b>Ação</b></td>
        </tr>
        
<?php
query_posts('cat='.$id_categoria1);

if (have_posts()){
    while (have_posts()) : the_post();
    echo "<tr>";
  echo "<td><a href=\"".get_the_permalink()."\" title=\"".get_the_title()."\">".get_the_title()."</a></td>";
  echo "<td><a class=\"btn btn-primary\" data-toggle=\"modal\" href=\"#modal-id-".get_the_ID()."\">".qtde_incritos(get_the_ID())."</a>
<div class=\"modal fade bs-example-modal-lg\" id=\"modal-id-".get_the_ID()."\">
    <div class=\"modal-dialog modal-lg\">
        <div class=\"modal-content\">
            <div class=\"modal-header\">
                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>
                <h4 class=\"modal-title\">".get_the_title()."</h4>
            </div>
            <div class=\"modal-body\">
                ".listar_todos(get_the_ID())."

        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal --></td>";
  echo "<td><a href=\"". plugin_dir_url( $file ) . 'inscricao-de-eventos/templates/'."xls.php?id_post=".get_the_ID()."&titulo=".get_the_title()."\" target=\"_blank\" title=\"Exportar em XLS\">Exportar</a></td>";
  echo "</tr>";
    endwhile;
}
?>
    </tbody>
</table>







                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
        b
    </div>

    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
        c
    </div>



</div>