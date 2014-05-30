<?php
/*
 * Sincroniza os dados de um usuário
 * Plugin: Sincronizador de Dados SAP
 * Desenvolvido pela MontarSite - 2014 - www.montarsite.com.br
 */

if ( !defined( 'ABSPATH' ) || !is_admin() || !current_user_can('manage_options') )
	wp_die('Acesso restrito.');

$user_id = intval( $_GET['user_id'] );

/*
@apache_setenv('no-gzip', 1);
@ini_set('output_buffering', 0);
@ini_set('zlib.output_compression', 0);
@ini_set('implicit_flush', 1);
for ($i = 0; $i < ob_get_level(); $i++) { ob_end_flush(); }
ob_implicit_flush(1);
ob_start();
echo str_repeat(" ", 1024), "\n";
*/
?>



<h1>Sincronizador SAP</h1>

<p>
<a href="<?php print admin_url("/user-edit.php?user_id=$user_id") ?>">&larr; Voltar para o perfil</a>
</p>



<?php

if ( !$user_id ) {
	print '<p>Nenhum usuário foi especificado!</p>';
	exit;
}

$user = get_userdata( $user_id );

if ( !$user ) {
	print "<p>O usuário de ID #$user_id não existe!</p>";
	exit;
}

$perfil = perfilUsuario( $user );

$ultimaSinc = umVerdadeiroDe(
	formatarTempo( obter( $perfil, 'sap_ultima_sinc' ) ),
	'Nunca'
);

print "<p>Usuário \"" . esc_html( $perfil['display_name'] ) . "\" de ID #$user_id.</p>";
print "<p>Última sincronização: $ultimaSinc.</p>";
print "<p>Sincronizando dados do usuário na SAP pelo username \"$user->user_login\"...</p>";

// print "<pre dump>";
// print_r( $perfil );
// print "</pre>";

$resultado = sap_sincronizarUsuario( $perfil );

// print "<p>Resposta do servidor:</p>";
// print "<pre dump>";
// print_r( $resultado );
// print "</pre>";

print $resultado['status']
	? "<p style='color:#7a0'>Operação foi bem-sucedida!</p>"
	: "<p style='color:#c30'>A operação falhou.</p>"
;

?>