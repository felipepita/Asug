<?php
/*
 * Campos extras na edição de perfis no backend
 * Desenvolvido pela MontarSite - www.montarsite.com.br - 2014
 */
 
 
 
// Ações

// Editar próprio perfil
add_action( 'show_user_profile', 'acao_perfil_campos_extras', 1, 1 );
add_action( 'show_user_profile', 'acao_perfilDicaAvatar', 10, 0 );
// Editar perfil de outros
add_action( 'edit_user_profile', 'acao_perfil_campos_extras', 1, 1 );
add_action( 'edit_user_profile', 'acao_perfilDicaAvatar', 10, 0 );
// Erro
add_action( 'user_profile_update_errors', 'acao_perfilErros', 10, 3 );
// Salvar perfil
add_action( 'edit_user_profile_update', 'acao_perfil_salvar', 20, 1 );
// Deletar usuário
add_action( 'delete_user', 'acao_deletarUsuario' );

 
 
// Mostrar



function acao_perfil_campos_extras( $user ) {
	// Mostra os campos novos conforme o tipo de usuário
	// @requer funcaoDesteUsuario, usuarioEstaAtivo
	ajustarFusoHorario();
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
					<?php if ( $user_funcao == FUNCAO_FUNCIONARIO || $user_funcao == FUNCAO_REPRESENTANTE ) : ?>
						<p class="description">(para alterar, acesse o perfil da empresa e altere o ID do representante n&ordm;1)</p>
					<?php endif; ?>
				</td>
			</tr>
			<tr>
				<th scope="row">
					Status geral
				</th>
				<td>
					<?php
					print $user_status['status']
						? '<span style="color:#7a0">Ativo</span>'
						: '<span style="color:#c30">Inativo</span>'
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
			<?php if ( $user_funcao != FUNCAO_EMPRESA && $user_funcao != FUNCAO_ADMIN ) : ?>
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
							<p class="description">Ao confirmar o e-mail, uma senha aleatória será gerada para esta conta e esta será enviada por e-mail para o usuário.</p>
							<?php /*
							<br /><br />
							<button type="button" class="button" onclick="alert('Não implementado.')">Enviar e-mail de confirmação</button>
							*/ ?>
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
				<?php
			endif;
			if ( $user_funcao != FUNCAO_EMPRESA ) :
				?>
				<tr>
					<th scope="row">
						Última Sinc. no SAP
					</th>
					<td>
						<?php if ( isset( $user_meta['sap_ultima_sinc'] ) ) : ?>
							<?php print formatarTempo( $user_meta['sap_ultima_sinc'] ) ?>
							(há <?php print human_time_diff( $user_meta['sap_ultima_sinc'] ) ?> atrás)
						<?php else : ?>
							Nunca
						<?php endif; ?>
						<br /><br />
						<a href="<?php print admin_url('/options.php?page=sap_sincronizador&user_id='.$user->ID) ?>" class="button">Sincronizar Agora</a>
					</td>
				</tr>
				<?php
			else :
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
						Associados Cadastrados
					</th>
					<td>
						<strong><?php print count( $user_meta['usuarios'] ) ?></strong>
						(listar por sufixo:<?php
						foreach ( $user_meta['sufixo'] as $sufixo ) {
							print "<a href='" . admin_url( "users.php?s=%40$sufixo" ) . "' style='margin: 0 0.25em'>$sufixo</a>";
						}
						?>)
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
					<label for="form-tratamento">Tratamento</label>
				</th>
				<td>
					<select id="form-tratamento" name="tratamento">
						<?php gerarLista( 'tratamento', $user_meta['tratamento'] ) ?>
					</select>
				</td>
			</tr>
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
					<label for="form-cargo_asug">Cargo na ASUG</label>
				</th>
				<td>
					<select id="form-cargo_asug" name="cargo_asug">
						<?php gerarLista( 'cargo_asug', obter( $user_meta, 'cargo_asug', 'ASS' ) ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cargo">Cargo</label>
				</th>
				<td>
					<select id="form-cargo" name="cargo">
						<?php gerarLista( 'cargo', obter( $user_meta, 'cargo', '' ) ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-nivel_cargo">Departamento</label>
				</th>
				<td>
					<select id="form-nivel_cargo" name="nivel_cargo">
						<?php gerarLista( 'nivel_cargo', $user_meta['nivel_cargo'] ) ?>
					</select>
				</td>
			</tr>
			<?php /*
			<tr>
				<th scope="row">
					<label for="form-capacitacao">Nível de capacitação</label>
				</th>
				<td>
					<select id="form-capacitacao" name="capacitacao">
						<?php gerarLista( 'capacitacao', $user_meta['capacitacao'] ) ?>
					</select>
				</td>
			</tr>
			*/ ?>
			<tr>
				<th scope="row">
					<label for="form-telefone">Telefone</label>
				</th>
				<td>
					<input id="form-telefone" name="telefone" type="text" class="regular-text input-telefone" value="<?php print formatarTelefone( $user_meta['telefone'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-fax">Fax</label>
				</th>
				<td>
					<input id="form-fax" name="fax" type="text" class="regular-text input-telefone" value="<?php print formatarTelefone( $user_meta['fax'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cep">CEP</label>
				</th>
				<td>
					<input id="form-cep" name="cep" type="text" class="regular-text input-cep" value="<?php print formatarCEP( $user_meta['cep'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-endereco">Endereço</label>
				</th>
				<td>
					<input id="form-endereco" name="endereco" type="text" class="regular-text input-endereco" value="<?php print esc_attr( $user_meta['endereco'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-complemento">Complemento</label>
				</th>
				<td>
					<input id="form-complemento" name="complemento" type="text" class="regular-text input-complemento" value="<?php print esc_attr( $user_meta['complemento'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-bairro">Bairro</label>
				</th>
				<td>
					<input id="form-bairro" name="bairro" type="text" class="regular-text input-bairro" value="<?php print esc_attr( $user_meta['bairro'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cidade">Cidade</label>
				</th>
				<td>
					<input id="form-cidade" name="cidade" type="text" class="regular-text input-cidade" value="<?php print esc_attr( $user_meta['cidade'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-estado">Estado</label>
				</th>
				<td>
					<select id="form-estado" name="estado" class="input-estado">
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
					<label for="form-sufixo">Sufixo(s) de e-mail</label>
				</th>
				<td>
					<input id="form-sufixo" name="sufixo" type="text" class="regular-text" value="<?php print implode( ', ', $user_meta['sufixo'] ) ?>">
					<p class="description">(separe múltiplos domínios por vírgulas)</p>
				</td>
			</tr>
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
					CNPJ
				</th>
				<td>
					<input id="form-cnpj" name="cnpj" type="text" class="regular-text input-cnpj" value="<?php print formatarCNPJ( sanitizarNumerico( $user_meta['cnpj'] ) ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-ramo">Ramo</label>
				</th>
				<td>
					<select id="form-ramo" name="ramo">
						<?php gerarLista( 'ramo', $user_meta['ramo'] ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-faturamento">Faturamento</label>
				</th>
				<td>
					<select id="form-faturamento" name="faturamento">
						<?php gerarLista( 'faturamento', $user_meta['faturamento'] ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-qtd_funcionarios">Quantidade de Funcionários</label>
				</th>
				<td>
					<select id="form-qtd_funcionarios" name="qtd_funcionarios">
						<?php gerarLista( 'qtd_funcionarios', $user_meta['qtd_funcionarios'] ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-qtd_usuarios">Quantidade de Usuários</label>
				</th>
				<td>
					<select id="form-qtd_usuarios" name="qtd_usuarios">
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
					<input id="form-telefone" name="telefone" type="text" class="regular-text input-telefone" value="<?php print formatarTelefone( $user_meta['telefone'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-fax">Fax</label>
				</th>
				<td>
					<input id="form-fax" name="fax" type="text" class="regular-text input-telefone" value="<?php print formatarTelefone( $user_meta['fax'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cep">CEP</label>
				</th>
				<td>
					<input id="form-cep" name="cep" type="text" class="regular-text input-cep" value="<?php print formatarCEP( $user_meta['cep'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-endereco">Endereço</label>
				</th>
				<td>
					<input id="form-endereco" name="endereco" type="text" class="regular-text input-endereco" value="<?php print esc_attr( $user_meta['endereco'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-complemento">Complemento</label>
				</th>
				<td>
					<input id="form-complemento" name="complemento" type="text" class="regular-text input-complemento" value="<?php print esc_attr( $user_meta['complemento'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-bairro">Bairro</label>
				</th>
				<td>
					<input id="form-bairro" name="bairro" type="text" class="regular-text input-bairro" value="<?php print esc_attr( $user_meta['bairro'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cidade">Cidade</label>
				</th>
				<td>
					<input id="form-cidade" name="cidade" type="text" class="regular-text input-cidade" value="<?php print esc_attr( $user_meta['cidade'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-estado">Estado</label>
				</th>
				<td>
					<select id="form-estado" name="estado" class="input-estado">
						<?php gerarLista( 'estado', $user_meta['estado'] ) ?>
					</select>
				</td>
			</tr>
			<?php /*
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
			*/ ?>
		</tbody>
	</table>
	
	
	
	<h3>Responsáveis pela Empresa</h3>
	
	
	
	<h4>Representante n&ordm;1</h4>
	
	<table class="form-table">
		<tbody>
			<tr>
				<th scope="row">
					<label for="form-rep1_user_id">ID</label>
				</th>
				<td>
					<input id="form-rep1_user_id" name="rep1_user_id" type="text" class="small-text" value="<?php print $rep1_id ?>">
					<?php print '<a href="' . admin_url( 'user-edit.php?user_id=' . $rep1_id ) . '" title="Ver o perfil deste usuário">(visualizar perfil)</a>' ?>
					<p class="description">Insira outro ID para alterar o representante desta empresa.</p>
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
					<?php print obterItem( 'cargo', $rep1_cargo ) ?>
				</td>
			</tr>
			<tr>
				<th scope="row">
					Departamento
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
					<label for="form-rep2_nome_completo">Nome</label>
				</th>
				<td>
					<input id="form-rep2_nome_completo" name="rep2_nome_completo" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['representante2']['nome_completo'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-rep2_email">E-mail</label>
				</th>
				<td>
					<input id="form-rep2_email" name="rep2_email" type="email" class="regular-text input-email" value="<?php print esc_attr( $user_meta['representante2']['email'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-rep2_cargo">Cargo</label>
				</th>
				<td>
					<select id="form-rep2_cargo" name="rep2_cargo">
						<?php gerarLista( 'cargo', obter( $user_meta['representante2'], 'cargo' ) ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-rep2_nivel_cargo">Departamento</label>
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
					<input id="form-rep2_telefone" name="rep2_telefone" type="text" class="regular-text input-telefone" value="<?php print formatarTelefone( $user_meta['representante2']['telefone'] ) ?>">
				</td>
			</tr>
		</tbody>
	</table>
	
	
	
	<h4>CIO</h4>
	
	<table class="form-table">
		<tbody>
			<tr>
				<th scope="row">
					<label for="form-cio_nome_completo">Nome</label>
				</th>
				<td>
					<input id="form-cio_nome_completo" name="cio_nome_completo" type="text" class="regular-text" value="<?php print esc_attr( $user_meta['cio']['nome_completo'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cio_email">E-mail</label>
				</th>
				<td>
					<input id="form-cio_email" name="cio_email" type="email" class="regular-text input-email" value="<?php print esc_attr( $user_meta['cio']['email'] ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cio_cargo">Cargo</label>
				</th>
				<td>
					<select id="form-cio_cargo" name="cio_cargo">
						<?php gerarLista( 'cargo', obter( $user_meta['cio'], 'cargo' ) ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-cio_nivel_cargo">Departamento</label>
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
					<input id="form-cio_telefone" name="cio_telefone" type="text" class="regular-text input-telefone" value="<?php print formatarTelefone( $user_meta['cio']['telefone'] ) ?>">
				</td>
			</tr>
		</tbody>
	</table>
	
	
	
	<h4>Responsável pelo Pagamento da Anuidade</h4>
	
	<table class="form-table">
		<tbody>
			<tr>
				<th scope="row">
					<label for="form-fin_nome_completo">Nome</label>
				</th>
				<td>
					<input id="form-fin_nome_completo" name="fin_nome_completo" type="text" class="regular-text" value="<?php print esc_attr( obter( $user_meta['financeiro'], 'nome_completo' ) ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-fin_email">E-mail</label>
				</th>
				<td>
					<input id="form-fin_email" name="fin_email" type="email" class="regular-text input-email" value="<?php print esc_attr( obter( $user_meta['financeiro'], 'email' ) ) ?>">
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-fin_cargo">Cargo</label>
				</th>
				<td>
					<select id="form-fin_cargo" name="fin_cargo">
						<?php gerarLista( 'cargo', obter( $user_meta['financeiro'], 'cargo' ) ) ?>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="form-fin_nivel_cargo">Departamento</label>
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
					<input id="form-fin_telefone" name="fin_telefone" type="text" class="regular-text input-telefone" value="<?php print formatarTelefone( obter( $user_meta['financeiro'], 'telefone' ) ) ?>">
				</td>
			</tr>
		</tbody>
	</table>
	
	
	
	<?php elseif ( $user_funcao == FUNCAO_ADMIN ) : ?>
	
	
	
	<table class="form-table">
		<tbody>
			<tr>
				<th scope="row">
					<label for="form-tratamento">Tratamento</label>
				</th>
				<td>
					<select id="form-tratamento" name="tratamento">
						<?php gerarLista( 'tratamento', $user_meta['tratamento'] ) ?>
					</select>
				</td>
			</tr>
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
					<label for="form-organizacao">Organização</label>
				</th>
				<td>
					<input id="form-organizacao" name="organizacao" type="text" class="regular-text" value="<?php print esc_attr( obter( $user_meta, 'organizacao' ) ) ?>">
				</td>
			</tr>
		</tbody>
	</table>
	
	
	
	<?php
	endif;
	if ( $user_funcao != FUNCAO_ADMIN ) : ?>
	
		
		
	<script src="<?php print trailingslashit( get_template_directory_uri() ) . 'js/ajaxform.js' ?>"></script>
		
	<script>
	
		// Esconde controle de alteração de função para não-admins
		jQuery('#role').attr('name', 'nao_utilizado1').parents('tr').hide();
		// Esconde campos supérfluos para alteração de nome
		jQuery('#nickname').attr('name', 'nao_utilizado2').parents('tr').hide();
		jQuery('#display_name').attr('name', 'nao_utilizado3').parents('tr').hide();
		// Esconde campo de alteração de e-mail
		jQuery('#email').parents('tr').hide();
	
	</script>
		
		
	
	<?php
	endif;
}



// Dica de dimensões para o avatar

function acao_perfilDicaAvatar() {
	?>
	
<table class="form-table" style="margin-top: 0;">
	<tbody>
		<tr>
			<th>Formato</th>
			<td>
				<p class="description">Utilize uma imagem em formato JPEG, PNG ou GIF com dimensão 150x150.</p>
			</td>
		</tr>
	</tbody>
</table>

<script>
	// Esconde a classificação no avatar
	jQuery('#simple-local-avatar-ratings').parents('tr').hide();
</script>

	<?php
}



// Salvar



function acao_perfil_salvar( $usuario ) {
	// Salva as edições no perfil
	global $mensagens, $perfis;
	define( 'OK', true );
	require TEMPLATEPATH . '/inc/ctrl.admin-perfis.php';
}



// Erros

function acao_perfilErros( &$errors, $update, &$user ) {
	// Faz com que os erros ao salvar o perfil sejam retornados
	global $erro, $mensagens;
	if ( $erro ) {
		foreach ( $mensagens as $txt ) {
			$errors->add( 'invalido', $txt );
		}
	}
}



// Deletar usuário

function acao_deletarUsuario( $user_id ) {
	$funcao = funcaoDesteUsuario( $user_id );
	if ( $funcao != FUNCAO_EMPRESA ) {
		// Desativa o usuário na SAP, já que é impossível excluí-lo remotamente
		$perfil = perfilUsuario( $user_id );
		$perfil['user_login'] = "excluido#$user_id";
		$perfil['status'] = 0;
		$perfil['funcao'] = $perfil['empresa_tipo_associacao'] = $perfil['empresa_nome'] = $perfil['nivel_cargo'] = 'Excluído';
		$perfil['representante1_telefone'] = '';
		sap_sincronizarUsuario( $perfil );
	}
}

