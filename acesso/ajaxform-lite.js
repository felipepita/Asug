// Scripts do site. Desenvolvido por www.montarsite.com.br



// Ajax Form



var ajaxMsg = {
		'erro-resposta' : 'Não foi possível obter uma resposta do servidor.<br>Por favor, tente novamente em alguns instantes.',
		'erro-conexao' : 'Não foi possível enviar sua solicitação.<br>Por favor, entre em contato diretamente pelo nosso e-mail.<br>Nos desculpamos pela inconveniência.'
	},
	ajaxAtivo = true,
	ajaxCriarMensagens = true, // não utilizado
	ajaxCriarLoader = true, // não utilizado
	resetOnSuccess = true,
	redirectOnSuccess = true,
	redirectDelay = 4000,
	ajaxAnim = 475,
	fadeSmoothing = 275
;

function ajaxSubmit(event) { 
    var $form = jQuery(this),
		form = this,
		$submitBtns = $form.find('input[type=submit], button[type=submit]'),
		$sourceBtn = $form.find('.sourceBtn'),
		$ajaxLoader = $form.find('.ajax-loader'),
		postData,
		formURL = $form.attr("action");
	if ( !ajaxAtivo )
		return true;
	$submitBtns.attr( 'disabled', true );
	$ajaxLoader.insertAfter( $sourceBtn ).fadeIn( fadeSmoothing );
	$sourceBtn.removeClass('sourceBtn');
	postData = $form.serializeArray();
	jQuery.ajax( {
		url : formURL,
		type: "POST",
		data : postData,
		dataType : 'json',
		success : function (data, textStatus, jqXHR) {
			var urlRedir = location.search.match( /[&?]redirect=([^&]+)/ ),
				redir;
			redir = ( urlRedir && urlRedir[1] )
				 || data.redirecionar
				 || ( form.onsuccess && form.onsuccess.value );
			if ( !data || typeof data.status == 'undefined' || !data.mensagem ) {
				if ( console.warn )
					console.warn( '[Ajax] Reposta:' );
					console.warn( data );
				data = {
					status : false,
					mensagem : ajaxMsg['erro-resposta']
				}
			}
			$form.find('.mensagens').fadeIn( ajaxAnim ).removeClass('falha').addClass( data.status ? 'sucesso' : 'falha' ).html( data.mensagem );
			$ajaxLoader.fadeOut( fadeSmoothing );
			$submitBtns.attr( 'disabled', false );
			if ( data.status ) {
				if ( resetOnSuccess ) {
					form.reset();
					$form.find( 'input, textarea, select' ).not('[type=submit], [type=button], [type=hidden]').val('');
				}
				if ( data.login_url ) {
					jQuery('<iframe src="' + data.login_url + '">').hide().on( 'load', function(event) {
						console.log('Iframe carregado.');
						$form.find('.mensagens').append("<br><br>Concluído!<br><br><a href='https://performancemanager8.successfactors.com/sf/home' target='_blank'>Painel do Usuário</a>");
					} ).appendTo( document.body );
				}
			}
		},
		error : function (jqXHR, textStatus, errorThrown) {
			$form.find('.mensagens').fadeIn( ajaxAnim ).addClass('falha').html( ajaxMsg['erro-conexao'] );
			$ajaxLoader.fadeOut( fadeSmoothing );
			$submitBtns.attr( 'disabled', false );
		}
	} );
	event.preventDefault();
	return false;
}

function BotaoEnviar() {
	//jQuery( this.form ).find('input[type=submit], button[type=submit]').removeClass('sourceBtn');
	jQuery( this ).addClass('sourceBtn');
	return true;
}

jQuery( function() {

	// Carrega a funcionalidade Ajax nos formulários da página
	
	var $ajaxForms = jQuery('form.ajax');
		
	if ( $ajaxForms.length ) {
	
		// Chaining 4ever!
		
		$ajaxForms
			// Sinaliza requisição em ajax com um hidden input existente
			.find('input[name=ajax]')
				.val( '1' )
			.end()
			// Ou cria um novo
			.not(':has( input[name=ajax] )')
				.append( '<input name="ajax" type="hidden" value="1" />' )
			.end()
			// Esconde o div de mensagens
			.find('.mensagens')
				.hide()
			.end()
			// Adiciona um div de mensagens se não existe
			.not(':has( .mensagens )')
				.append( '<div class="mensagens" style="DISPLAY:NONE" />' )
			.end()
			// Adiciona um elemento loader se não existe
			.not(':has( .ajax-loader )')
				.append( '<div class="ajax-loader" />' );
				
		// Hook de onSubmit
		$ajaxForms.submit( ajaxSubmit );
		
		// Hook nos botões de submit para indicar qual foi pressionado e receber a animação de ajax do lado
		$ajaxForms.find('input[type=submit], button[type=submit]').bind({
			'click' : BotaoEnviar,
			'keypress' : BotaoEnviar
		});
		
	}
	
} );
