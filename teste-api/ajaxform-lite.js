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
					console.warn( '[Ajax] Reposta: ' + data );
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
				if ( redirectOnSuccess && redir ) {
					setTimeout( function() {
							location.href = redir;
						},
						redirectDelay
					);
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



// Input numérico



function inputInteiro(event) {
	this.value = this.value.replace( /\D|^0+/g, '' ) || 0;
}

jQuery( function() {
	jQuery('input.inteiro').bind({
		'keyup' : inputInteiro,
		'paste' : inputInteiro,
		'blur' : inputInteiro
	});
});



// Input de data



function inputData(event) {
	var val = this.value.replace( /\D/g, '' ),
		format;
	format = val.substring( 0, 2 );
	if ( val.length >= 2 )
		format += '/' + val.substring( 2, 4 );
	if ( val.length >= 4 )
		format += '/' + val.substring( 4, 8 );
	this.value = format;
}

var isDateInputSupported = function() {
	// by Kent Tamura
	// http://updates.html5rocks.com/2012/08/Quick-FAQs-on-input-type-date-in-Google-Chrome
	var elem = document.createElement('input');
	elem.setAttribute('type','date');
	elem.value = 'foo';
	return (elem.type == 'date' && elem.value != 'foo');
}

jQuery( function() {
	// Testa capabilidade do browser
	/*
	var dataTeste = document.querySelector('input[type=data]'),
		suportaData = false;
	if ( dataTeste && ( dataTeste.value = 'a' ) != 'a' )
		suportaData = true;
	// Se não suporta data, habilitar máscara de input
	if ( !suportaData )
	*/
	if ( !isDateInputSupported() )
		jQuery('input.data').bind({
			'keyup' : inputData,
			'paste' : inputData
		});
});



// Input de telefone



function inputTelefone(event) {
	var val = this.value.replace( /^0+|\D/g, '' ),
		format = '';
	if ( val.length )
		format = '(' + val.substring( 0, 2 );
	if ( val.length >= 2 )
		format += ') ';
	if ( val.length == 11 ) {
		format += val.substring( 2, 5 ) + '-'
				+ val.substring( 5, 8 ) + '-'
				+ val.substring( 8, 11 );
	} else {
		format += val.substring( 2, 6 );
		if ( val.length >= 6 )
			format += '-' + val.substring( 6, 10 );
	}
	this.value = format;
}

jQuery( function() {
	jQuery('input.telefone').bind({
		'keyup' : inputTelefone,
		'paste' : inputTelefone
	});
});



// Simula input placeholders no IE < 10



function inputFocus() {
	if ( this.value == this.defaultValue )
		this.value = '';
}

function inputBlur() {
	if ( !this.value )
		this.value = this.defaultValue;
}

jQuery( function() {
	var inputs,
		i;
	if ( /MSIE [6-9]/.test( navigator.userAgent ) ) {
		inputs = document.getElementsByTagName('input');
		for ( i = 0; i < inputs.length; i++ ) {
			if ( inputs[i].placeholder ) {
				inputs[i].defaultValue = inputs[i].placeholder;
				if ( !inputs[i].value )
					inputs[i].value = inputs[i].placeholder;
				inputs[i].onfocus = inputFocus;
				inputs[i].onblur = inputBlur;
			}
		}
	}
});



// CSS para IE <= 8



jQuery( function() {
	if ( /MSIE [6-8]/.test( navigator.userAgent ) ) {
		jQuery( document.body ).addClass('ie-legacy');
		//jQuery.support.cors = true;
	}
});