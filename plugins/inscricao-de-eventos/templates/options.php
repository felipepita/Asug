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
        tb_show( '', 'media-upload.php?type=image&amp;TB_iframe=true' );
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
$id_categoria1 = "21";
$id_categoria2 = "22";
$id_categoria3 = "23";
        ?>
<script type="text/javascript">
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

<link rel="stylesheet" media="screen" href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
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
            </div>
            <div class=\"modal-footer\">
                <button type=\"button\" class=\"btn btn-primary\" data-dismiss=\"modal\">Fechar</button>
            </div>
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