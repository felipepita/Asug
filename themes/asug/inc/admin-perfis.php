<?php
/*
 * Campos extras na edição de perfis no backend
 * Desenvolvido pela MontarSite - www.montarsite.com.br - 2014
 */
 
 
 
// Mostrar



function acao_perfil_campos_extras( $user ) {
	// Mostra os campos novos conforme o tipo de usuário
	// @requer funcaoDesteUsuario, usuarioEstaAtivo
	$user_meta = array_map( 'mapMeta', get_user_meta( $user->ID ) );
	$user_funcao = funcaoDesteUsuario( $user );
	$user_status = usuarioEstaAtivo( $user, true );
	if ( $user_funcao == FUNCAO_EMPRESA ) {
		$rep1_id = $user_meta['representante1'];
		$rep1 = get_userdata( $rep1_id );
		$rep1_cargo = get_user_meta( $rep1_id, 'cargo', true );
		$rep1_nivel_cargo = get_user_meta( $rep1_id, 'nivel_cargo', true );
		$rep1_telefone = get_user_meta( $rep1_id, 'telefone', true );
		$rep1_status = usuarioEstaAtivo( $rep1, true );
	}
	?>
	
	
	
	<table class="form-table">
		<tbody>
			<tr>
				<th scope="row">
					ID
				</th>
				<td>
					<?php print $user->ID ?>
				</td>
			</tr>
			<tr>
				<th scope="row">
					Data de registro
				</th>
				<td>
					<?php print formatarData( $user->user_registered ) ?>
				</td>
			</tr>
			<tr>
				<th scope="row">
					Função
				</th>
				<td>
					<?php print obterItem( 'funcoes', $user_funcao ) ?>
				</td>
			</tr>
			<tr>
				<th scope="row">
					Status geral
				</th>
				<td>
					<?php
					print $user_status['status']
						? 'Ativo'
						: 'Inativo'
					;
					print " ($user_status[motivo])";
					?>
				</td>
			</tr>
			<tr>
				<th scope="row">
					Alterar status
				</th>
				<td>
					<?php if ( $user_funcao == FUNCAO_EMPRESA ) : ?>
						<a href="<?php print admin_url( 'users.php?page=user-status-manager/start.php&amp;strUserSearch=' . $rep1->user_email ) ?>">Alterar status do representante n&ordm;1</a>
					<?php else : ?>
						<a href="<?php print admin_url( 'users.php?page=user-status-manager/start.php&amp;strUserSearch=' . $user->user_email ) ?>">Alterar status desta conta</a>
					<?php endif; ?>
				</td>
			</tr>
			<?php if ( $user_funcao != FUNCAO_EMPRESA ) : ?>
				<tr>
					<th scope="row">
						Confirmar e-mail
					</th>
					<td>
						<label for="form-email_confirmado">
							<input id="form-email_confirmado" name="email_confirmado" type="checkbox" value="1" <?php if ( obter( $user_meta, 'email_confirmado' ) ) print 'checked' ?>>
							Endereço de e-mail confirmado
						</label>
						<?php if ( !obter( $user_meta, 'email_confirmado' ) ) : ?>
							<br /><br />
							<button type="button" class="button" onclick="alert('Não implementado.')">Enviar e-mail de confirmação</button>
						<?php endif; ?>
					</td>
				</tr>
			<?php endif; ?>
			<?php
			if ( $user_funcao == FUNCAO_FUNCIONARIO || $user_funcao == FUNCAO_REPRESENTANTE ) :
				$empresa = get_userdata( $user_meta['empresa'] );
				?>
				<tr>
					<th scope="row">
						Empresa
					</th>
					<td>
						<?php print '<a href="' . admin_url( 'user-edit.php?user_id=' . $empresa->ID ) . '" title="Ver o perfil da empresa">' . esc_html( $empresa->display_name ) . '</a>' ?>
					</td>
				</tr>
				<tr>
					<th scope="row">
						Último Sync no SAP
					</th>
					<td>
						<?php if ( isset( $user_meta['sap_ultimo_sync'] ) ) : ?>
							<?php print formatarTempo( $user_meta['sap_ultimo_sync'] ) ?>
							(<?php print human_time_diff( $user_meta['sap_ultimo_sync'] ) ?>)
						<?php else : ?>
							Nunca
						<?php endif; ?>
						<br /><br />
						<button type="button" class="button" onclick="alert('Não implementado.')">Sincronizar Agora</button>
					</td>
				</tr>
				<?php
			elseif ( $user_funcao == FUNCAO_EMPRESA ) :
				?>
				<tr>
					<th scope="row">
						Tipo de Associação
					</th>
					<td>
						<select id="form-tipo_associacao" name="tipo_associacao">
							<?php gerarLista( 'tipo_associacao', $user_meta['tipo_associacao'] ) ?>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row">
						Funcionários Cadastrados
					</th>
					<td>
						<strong><?php print count( $user_meta['usuarios'] ) ?></strong>
						<?php print '<a href="' . admin_url( 'users.php?s=%40' . $user_meta['sufixo'] ) . '">(listar todos)</a>' ?>
					</td>
				</tr>
				<?php
			endif;
			?>
		</tbody>
	</table>
	
	
	
	<?php if ( $user_funcao == FUNCAO_FUNCIONARIO || $user_funcao == FUNCAO_REPRESENTANTE ) : ?>
	
	
	
	<h3>Informações Pessoais</h3>
	
	
	
	<table class="form-table">
		<tbody>
			<tr>
				<th scope="row">
					<label for="form-sexo">Sexo</label>
				</th>
				<td>
					<select id="form-sexo" name="sexo">
						<?php gerarLista( 'sexo', $user_meta['sexo'] ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cargo">Cargo</label>
				</th>
				<td>
					<input id="form-cargo" name="cargo" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['cargo'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-nivel_cargo">Nível do cargo</label>
				</th>
				<td>
					<select id="form-nivel_cargo" name="nivel_cargo">
						<?php gerarLista( 'nivel_cargo', $user_meta['nivel_cargo'] ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-telefone">Telefone</label>
				</th>
				<td>
					<input id="form-telefone" name="telefone" type="text" class="regular-text" value="<?php print formatarTelefone( $user_meta['telefone'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cep">CEP</label>
				</th>
				<td>
					<input id="form-cep" name="cep" type="text" class="regular-text" value="<?php print formatarCEP( $user_meta['cep'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-endereco">Endereço</label>
				</th>
				<td>
					<input id="form-endereco" name="endereco" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['endereco'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-complemento">Complemento</label>
				</th>
				<td>
					<input id="form-complemento" name="complemento" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['complemento'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-bairro">Bairro</label>
				</th>
				<td>
					<input id="form-bairro" name="bairro" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['bairro'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cidade">Cidade</label>
				</th>
				<td>
					<input id="form-cidade" name="cidade" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['cidade'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-estado">Estado</label>
				</th>
				<td>
					<select id="form-estado" name="estado">
						<?php gerarLista( 'estado', $user_meta['estado'] ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-informativo">Informativo</label>
				</th>
				<td>
					<label for="form-informativo">
						<input id="form-informativo" name="informativo" type="checkbox" value="1" <?php if ( $user_meta['informativo'] ) print 'checked' ?>>
						Desejo receber o informativo da ASUG 
					</label>
				</td>
			</tr>
		</tbody>
	</table>
	
	
	
	<?php elseif ( $user_funcao == FUNCAO_EMPRESA ) : ?>
	
	
	
	<h3>Informações da Empresa</h3>
	
	<table class="form-table">
		<tbody>
			<?php /*
			<tr>
				<th scope="row">
					<label for="form-nome_fantasia">Nome Fantasia</label>
				</th>
				<td>
					<input id="form-nome_fantasia" name="nome_fantasia" type="text" class="regular-text" value="<?php print esc_attr( $user->display_name ) ?>">
				</td>
			</tr>
			*/ ?>
			<tr>
				<th scope="row">
					<label for="form-razao_social">Razão Social</label>
				</th>
				<td>
					<input id="form-razao_social" name="razao_social" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['razao_social'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-grupo_controlador">Grupo Controlador</label>
				</th>
				<td>
					<input id="form-grupo_controlador" name="grupo_controlador" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['grupo_controlador'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cnpj">CNPJ</label>
				</th>
				<td>
					<input id="form-cnpj" name="cnpj" type="text" class="regular-text" value="<?php print formatarCNPJ( $user_meta['cnpj'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-ramo">Ramo</label>
				</th>
				<td>
					<select id="form-ramo" name="estado">
						<?php gerarLista( 'ramo', $user_meta['ramo'] ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-faturamento">Faturamento</label>
				</th>
				<td>
					<select id="form-faturamento" name="estado">
						<?php gerarLista( 'faturamento', $user_meta['faturamento'] ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-qtd_funcionarios">Quantidade de Funcionários</label>
				</th>
				<td>
					<select id="form-qtd_funcionarios" name="estado">
						<?php gerarLista( 'qtd_funcionarios', $user_meta['qtd_funcionarios'] ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-qtd_usuarios">Quantidade de Usuários</label>
				</th>
				<td>
					<select id="form-qtd_usuarios" name="estado">
						<?php gerarLista( 'qtd_usuarios', $user_meta['qtd_usuarios'] ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-versao_erp">Versão do ERP</label>
				</th>
				<td>
					<input id="form-versao_erp" name="versao_erp" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['versao_erp'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-telefone">Telefone</label>
				</th>
				<td>
					<input id="form-telefone" name="telefone" type="text" class="regular-text" value="<?php print formatarTelefone( $user_meta['telefone'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-fax">Fax</label>
				</th>
				<td>
					<input id="form-fax" name="fax" type="text" class="regular-text" value="<?php print formatarTelefone( $user_meta['fax'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cep">CEP</label>
				</th>
				<td>
					<input id="form-cep" name="cep" type="text" class="regular-text" value="<?php print formatarCEP( $user_meta['cep'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-endereco">Endereço</label>
				</th>
				<td>
					<input id="form-endereco" name="endereco" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['endereco'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-complemento">Complemento</label>
				</th>
				<td>
					<input id="form-complemento" name="complemento" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['complemento'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-bairro">Bairro</label>
				</th>
				<td>
					<input id="form-bairro" name="bairro" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['bairro'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cidade">Cidade</label>
				</th>
				<td>
					<input id="form-cidade" name="cidade" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['cidade'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-estado">Estado</label>
				</th>
				<td>
					<select id="form-estado" name="estado">
						<?php gerarLista( 'estado', $user_meta['estado'] ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-contato_publico">Contato</label>
				</th>
				<td>
					<label for="form-contato_publico">
						<input id="form-contato_publico" name="contato_publico" type="checkbox" value="1" <?php if ( $user_meta['contato_publico'] ) print 'checked' ?>>
						Exibir informações de contato publicamente
					</label>
				</td>
			</tr>
		</tbody>
	</table>
	
	
	
	<h3>Responsáveis pela Empresa</h3>
	
	
	
	<h4>Representante n&ordm;1</h4>
	
	<table class="form-table">
		<tbody>
			<tr>
				<th scope="row">
					ID
				</th>
				<td>
					<?php print $rep1_id ?>
					<?php print '<a href="' . admin_url( 'user-edit.php?user_id=' . $rep1_id ) . '" title="Ver o perfil deste usuário">(visualizar perfil)</a>' ?>
				</td>
			</tr>
			<tr>
				<th scope="row">
					Status geral
				</th>
				<td>
					<?php
					print $rep1_status['status']
						? 'Ativo'
						: 'Inativo'
					;
					print " ($rep1_status[motivo])";
					?>
				</td>
			</tr>
			<tr>
				<th scope="row">
					Alterar status
				</th>
				<td>
					<a href="<?php print admin_url( 'users.php?page=user-status-manager/start.php&amp;strUserSearch=' . $rep1->user_email ) ?>">Alterar status desta conta</a>
				</td>
			</tr>
			<tr>
				<th scope="row">
					Nome
				</th>
				<td>
					<?php print esc_attr( $rep1->display_name ) ?>
				</td>
			</tr>
			<tr>
				<th scope="row">
					E-mail
				</th>
				<td>
					<?php print esc_attr( $rep1->user_email ) ?>
				</td>
			</tr>
			<tr>
				<th scope="row">
					Cargo
				</th>
				<td>
					<?php print esc_attr( $rep1_cargo ) ?>
				</td>
			</tr>
			<tr>
				<th scope="row">
					Nível do cargo
				</th>
				<td>
					<?php print obterItem( 'nivel_cargo', $rep1_nivel_cargo ) ?>
				</td>
			</tr>
			<tr>
				<th scope="row">
					Telefone
				</th>
				<td>
					<?php print formatarTelefone( $rep1_telefone ) ?>
				</td>
			</tr>
		</tbody>
	</table>
	
	
	
	<h4>Representante n&ordm;2</h4>
	
	<table class="form-table">
		<tbody>
			<tr>
				<th scope="row">
					<label for="form-rep2_nome">Nome</label>
				</th>
				<td>
					<input id="form-rep2_nome" name="rep2_nome" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['representante2']['nome_completo'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-rep2_email">E-mail</label>
				</th>
				<td>
					<input id="form-rep2_email" name="rep2_email" type="email" class="regular-text" value="<?php print esc_attr( $user_meta['representante2']['email'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-rep2_cargo">Cargo</label>
				</th>
				<td>
					<input id="form-rep2_cargo" name="rep2_cargo" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['representante2']['cargo'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-rep2_nivel_cargo">Nível do cargo</label>
				</th>
				<td>
					<select id="form-rep2_nivel_cargo" name="rep2_nivel_cargo">
						<?php gerarLista( 'nivel_cargo', $user_meta['representante2']['nivel_cargo'] ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-rep2_telefone">Telefone</label>
				</th>
				<td>
					<input id="form-rep2_telefone" name="rep2_telefone" type="text" class="regular-text" value="<?php print formatarTelefone( $user_meta['representante2']['telefone'] ) ?>">
				</td>
			</tr>
		</tbody>
	</table>
	
	
	
	<h4>CIO</h4>
	
	<table class="form-table">
		<tbody>
			<tr>
				<th scope="row">
					<label for="form-cio_nome">Nome</label>
				</th>
				<td>
					<input id="form-cio_nome" name="cio_nome" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['cio']['nome_completo'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cio_email">E-mail</label>
				</th>
				<td>
					<input id="form-cio_email" name="cio_email" type="email" class="regular-text" value="<?php print esc_attr( $user_meta['cio']['email'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cio_cargo">Cargo</label>
				</th>
				<td>
					<input id="form-cio_cargo" name="cio_cargo" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['cio']['cargo'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cio_nivel_cargo">Nível do cargo</label>
				</th>
				<td>
					<select id="form-cio_nivel_cargo" name="cio_nivel_cargo">
						<?php gerarLista( 'nivel_cargo', $user_meta['cio']['nivel_cargo'] ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cio_telefone">Telefone</label>
				</th>
				<td>
					<input id="form-cio_telefone" name="cio_telefone" type="text" class="regular-text" value="<?php print formatarTelefone( $user_meta['cio']['telefone'] ) ?>">
				</td>
			</tr>
		</tbody>
	</table>
	
	
	
	<h4>Responsável pelo Pagamento da Anuidade</h4>
	
	<table class="form-table">
		<tbody>
			<tr>
				<th scope="row">
					<label for="form-fin_nome">Nome</label>
				</th>
				<td>
					<input id="form-fin_nome" name="fin_nome" type="text" class="regular-text" value="<?php print esc_attr( obter( $user_meta['financeiro'], 'nome_completo' ) ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-fin_email">E-mail</label>
				</th>
				<td>
					<input id="form-fin_email" name="fin_email" type="email" class="regular-text" value="<?php print esc_attr( obter( $user_meta['financeiro'], 'email' ) ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-fin_cargo">Cargo</label>
				</th>
				<td>
					<input id="form-fin_cargo" name="fin_cargo" type="text" class="regular-text" value="<?php print esc_attr( obter( $user_meta['financeiro'], 'cargo' ) ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-fin_nivel_cargo">Nível do cargo</label>
				</th>
				<td>
					<select id="form-fin_nivel_cargo" name="fin_nivel_cargo">
						<?php gerarLista( 'nivel_cargo', obter( $user_meta['financeiro'], 'nivel_cargo' ) ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-fin_telefone">Telefone</label>
				</th>
				<td>
					<input id="form-fin_telefone" name="fin_telefone" type="text" class="regular-text" value="<?php print formatarTelefone( obter( $user_meta['financeiro'], 'telefone' ) ) ?>">
				</td>
			</tr>
		</tbody>
	</table>
	
	
	
	<?php elseif ( $user_funcao == FUNCAO_ADMIN ) : ?>
	
	<?php endif;
	
}

add_action( 'edit_user_profile', 'acao_perfil_campos_extras', 1, 1 );



// Salvar



function acao_perfil_salvar( $user ) {

	// Salva as edições no perfil
	// @requer funcaoDesteUsuario, usuarioEstaAtivo, mapMeta
	
	global $mensagens, $perfis;
	$user_meta = array_map( 'mapMeta', get_user_meta( $user->ID ) );
	$user_funcao = funcaoDesteUsuario( $user );
	$user_status = usuarioEstaAtivo( $user, true );
	$wp_error = new WP_Error();
	
	// Valida
	
	if ( !processarCampos('usuario_edicao') ) {
		foreach ( $mensagens as $txt ) {
			$wp_error->add( 'invalido', $txt );
		}
		return $wp_error;
	}
	
	// Salva
	
	foreach ( $perfis['usuario_edicao']['campos'] as $chave ) {
		if ( $_POST[ $chave ] != $user_meta[ $chave ] ) {
			update_user_meta( $user->ID, $chave, $_POST[ $chave ] );
			if ( $chave == 'email_confirmado' && $_POST[ $chave ] ) {
				// Remove o código de confirmação anterior
				delete_transient( $user->user_nicename . '_confirmacao_email' );
			}
		}
	}
	
}

add_action( 'edit_user_profile_update', 'acao_perfil_salvar', 10, 1 );
