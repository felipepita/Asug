// Scripts de formulário. Desenvolvido por www.montarsite.com.br



// Ajax Form



var ajaxMsg = {
		'erro-resposta' : 'Não foi possível obter uma resposta do servidor.<br>Por favor, tente novamente em alguns instantes.',
		'erro-conexao' : 'Não foi possível enviar sua solicitação.<br>Por favor, entre em contato diretamente pelo nosso e-mail.<br>Nos desculpamos pela inconveniência.'
	},
	ajaxAtivo = true,
	ajaxCriarMensagens = true, // não utilizado
	ajaxCriarLoader = true, // não utilizado
	ajaxCriarPopup = true,
	ajaxDebug = false,
	resetOnSuccess = true,
	redirectOnSuccess = false,
	redirectDelay = 4000,
	runOnSuccess = null,
	ajaxAnim = 475,
	fadeSmoothing = 275
;

function ajaxSubmit(event) { 
    var $form = jQuery(this),
		form = this,
		$submitBtns = $form.find('input[type=submit], button[type=submit]'),
		$sourceBtn = $form.find('.sourceBtn'),
		$ajaxLoader = $form.find('.ajax-loader'),
		$mensagens = $form.find('.mensagens'),
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
		dataType : ajaxDebug ? 'html' : 'json',
		success : function (data, textStatus, jqXHR) {
			if ( !data || typeof data.status == 'undefined' || !data.mensagem ) {
				if ( ajaxDebug ) {
					data = {
						status : false,
						mensagem : data
					};
				} else {
					data = {
						status : false,
						mensagem : ajaxMsg['erro-resposta']
					};
				}
			}
			$mensagens.fadeIn( ajaxAnim ).removeClass('bg-success bg-danger').addClass( data.status ? 'bg-success' : 'bg-danger' ).html( data.mensagem );
			// Remove animação de loading
			$ajaxLoader.fadeOut( fadeSmoothing );
			$submitBtns.attr( 'disabled', false );
			if ( data.status ) {
				if ( runOnSuccess ) {
					runOnSuccess( data );
				}
				if ( resetOnSuccess ) {
					form.reset();
					$form.find( 'input, textarea, select' ).not('[type=submit], [type=button], [type=hidden]').val('');
				}
			}
		},
		error : function (jqXHR, textStatus, errorThrown) {
			$mensagens.fadeIn( ajaxAnim ).addClass('bg-danger').html( ajaxMsg['erro-conexao'] );
			$ajaxLoader.fadeOut( fadeSmoothing );
			$submitBtns.attr( 'disabled', false );
			if ( ajaxDebug ) {
				$mensagens.fadeIn( ajaxAnim ).addClass('bg-danger').append( errorThrown );
			}
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
			// Esconde a caixa de mensagens
			.find('.mensagens')
				.hide()
			.end()
			// Adiciona uma caixa de mensagens se não existe
			.not(':has( .mensagens )')
				.append( '<p class="mensagens clearfix" style="DISPLAY:NONE" />' )
			.end()
			// Adiciona um elemento loader se não existe
			.not(':has( .ajax-loader )')
				.append( '<div class="ajax-loader" style="DISPLAY:NONE" />' );
				
		// Hook de onSubmit
		$ajaxForms.submit( ajaxSubmit );
		
		// Hook nos botões de submit para indicar qual foi pressionado e receber a animação de ajax do lado
		$ajaxForms.find('input[type=submit], button[type=submit]').bind({
			'click' : BotaoEnviar,
			'keypress' : BotaoEnviar
		});
		
	}
	
} );



// Input geral



function inputBackspace(event) {
	// Se o cursor estiver no final do input e o valor terminar num separador de número,
	// remove o separador e o número anterior ao separador ao pressionar backspace
	if ( this.selectionStart != this.value.length )
		return;
	if ( event.keyCode == 8 && /\d[-_,.\/\\()]\s*$/.test( this.value ) )
		this.value = this.value.trim().slice( 0, -1 );
}



// Input e busca de CEP



var ultimoCEP = 0;

function getEndereco(event) {
	// Fonte: http://www.lucaspeperaio.com.br/blog/busca-de-endereco-completo-por-cep-com-jquery-e-jsonp
	var cep = this.value.replace( /\D/g, '' ),
		$form = jQuery(this).parents('.grupo-cep, form').eq(0),
		numero = 0,
		$campos;
	if ( cep && cep.length == 8 && cep != ultimoCEP ) {
		$campos = $form.find(".input-endereco, .input-bairro, .input-cidade, .input-estado");
		$campos.addClass('carregando');
		jQuery.ajax({
			url : "http://cep.republicavirtual.com.br/web_cep.php",
			type : "POST",
			//data : "formato=json&cep=" + cep,
			data : "formato=javascript&cep=" + cep,
			dataType : 'script',
			success : function( rawData, textStatus, jqXHR ) {
				var data = resultadoCEP;
				ultimoCEP = cep;
				$campos.removeClass('carregando');
				if ( data["tipo_logradouro"] != '') {
					if ( data["resultado"] == '1' ) {
						$form.find(".input-endereco").val(
							unescape( data["tipo_logradouro"] ) + " " +
							unescape( data["logradouro"] )
						);
						$form.find(".input-bairro").val(
							unescape( data["bairro"] )
						);
						$form.find(".input-cidade").val(
							unescape( data["cidade"] )
						);
						$form.find(".input-estado").val(
							unescape( data["uf"] )
						);
					}
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				$campos.removeClass('carregando');
				console.warn( 'Busca de CEP: ' + textStatus + ' (' + errorThrown + ')' );
			}
		});
	}
}

function inputCEP(event) {
	var val = this.value.replace( /\D/g, '' ),
		format;
	format = val.substring( 0, 5 );
	if ( val.length >= 5 )
		format += '-' + val.substring( 5, 8 );
	this.value = format;
	if ( val.length == 8 )
		getEndereco.call(this);
}

jQuery( function() {
	jQuery('.input-cep').bind({
		'keydown' : inputBackspace,
		'keyup' : inputCEP,
		'paste' : inputCEP,
		'blur' : inputCEP
	}).attr( 'placeholder', '#####-###' ).attr( 'maxlength', 9 );
});




// Formatar Preço



function formatarPreco( valor, html ) {
	// Formata o output de preço
	valor = String( Math.round( valor ) );
	while ( valor.length < 3 ) {
		valor = "0" + valor;
	}
	if ( typeof html == "undefined" ) {
		html = true;
	}
	valor = ( html ? '<span class="preco">' : '' )
			+ ( html ? '<span class="moeda">R$</span>' : '' )
			+ ( html ? '<span class="unidade">' : '' )
			+ ( valor.length > 11 ? valor.slice( -14, -11 ) + '.' : '' )
			+ ( valor.length > 8 ? valor.slice( -11, -8 ) + '.' : '' )
			+ ( valor.length > 5 ? valor.slice( -8, -5 ) + '.' : '' )
			+ valor.slice( -5, -2 )
			+ ( html ? '</span><span class="centavos">' : '' )
			+ ','
			+ valor.slice( -2 )
			+ ( html ? '</span>' : '' )
		+ ( html ? '</span>' : '' );
	return valor;
}

function inputPreco(event) {
	// Formata o preço num input
	var val,
		preco;
	val = Math.abs( parseInt( this.value.replace( /^[0,]+|\D/g, '' ) ) ) || 0;
	//preco = Math.floor( val / 100 ) + ',' + ( val % 100 < 10 ? '0' : '' ) + ( val % 100 || '0' );
	preco = formatarPreco( val, false );
	this.value = preco;
}

jQuery( function() {
	jQuery('.input-preco').bind({
		'keyup' : inputPreco,
		'paste' : inputPreco
	});
});

Array.prototype.remove = function(from, to) {
	// Array Remove - By John Resig (MIT Licensed)
	var rest = this.slice((to || from) + 1 || this.length);
	this.length = from < 0 ? this.length + from : from;
	return this.push.apply(this, rest);
};



// Input de variável / username



function inputVar(event) {
	this.value = this.value.replace( /[^_A-Za-z0-9]/g, '' ).replace( /^[_\d]+/, '' );
}

jQuery( function() {
	jQuery('.input-var').bind({
		'keyup' : inputVar,
		'paste' : inputVar,
		'blur' : inputVar
	});
});



// Input numérico



function inputInteiro(event) {
	this.value = this.value.replace( /\D|^0+/g, '' ); // || 0;
}

jQuery( function() {
	jQuery('.input-inteiro').bind({
		'keyup' : inputInteiro,
		'paste' : inputInteiro,
		'blur' : inputInteiro
	});
});

function inputNumerico(event) {
	this.value = this.value.replace( /\D/g, '' );
}

jQuery( function() {
	jQuery('.input-numerico').bind({
		'keyup' : inputNumerico,
		'paste' : inputNumerico,
		'blur' : inputNumerico
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

/*
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
	if ( !isDateInputSupported() ) {
		jQuery('.input-data').bind({
			'keydown' : inputBackspace,
			'keyup' : inputData,
			'paste' : inputData
		}).attr( 'placeholder', 'DD/MM/AAAA' ).attr( 'maxlength', 10 );
	}
});
*/

jQuery('.input-data').bind({
	'keydown' : inputBackspace,
	'keyup' : inputData,
	'paste' : inputData
}).attr( 'placeholder', 'DD/MM/AAAA' ).attr( 'maxlength', 10 );



// Input de CNPJ



function inputCNPJ(event) {
	var val = this.value,
		format;
	val = val.replace( /\D/g, '' );
	format = val.substring( 0, 2 );
	if ( val.length >= 2 )
		format += '.' + val.substring( 2, 5 );
	if ( val.length >= 5 )
		format += '.' + val.substring( 5, 8 );
	if ( val.length >= 8 )
		format += '/' + val.substring( 8, 12 );
	if ( val.length >= 12 )
		format += '-' + val.substring( 12, 14 );
	this.value = format;
}

jQuery( function() {
	jQuery('.input-cnpj').bind({
		'keydown' : inputBackspace,
		'keyup' : inputCNPJ,
		'paste' : inputCNPJ
	}).attr( 'placeholder', '##.###.###/####-##' ).attr( 'maxlength', 18 );
});

function inputAssociacao(event) {
	var val = this.value;
	if ( /^[\.\d]{5,}/.test( val ) )
		return inputCNPJ.call( this, event );
}

jQuery( function() {
	jQuery('.input-associacao').bind({
		'keydown' : inputBackspace,
		'keyup' : inputAssociacao,
		'paste' : inputAssociacao,
		'change' : inputAssociacao
	}).attr( 'placeholder', '##.###.###/####-##' );
});



// Input de CPF



function inputCPF(event) {
	var val = this.value.replace( /\D/g, '' ),
		format;
	format = val.substring( 0, 3 );
	if ( val.length >= 3 )
		format += '.' + val.substring( 3, 6 );
	if ( val.length >= 6 )
		format += '.' + val.substring( 6, 9 );
	if ( val.length >= 9 )
		format += '-' + val.substring( 9, 11 );
	this.value = format;
}

jQuery( function() {
	jQuery('.input-cpf').bind({
		'keydown' : inputBackspace,
		'keyup' : inputCPF,
		'paste' : inputCPF
	}).attr( 'placeholder', '###.###.###-##' ).attr( 'maxlength', 14 );
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
	jQuery('.input-telefone').bind({
		'keydown' : inputBackspace,
		'keyup' : inputTelefone,
		'paste' : inputTelefone
	}).attr( 'placeholder', '(##) [#]####-####' ).attr( 'maxlength', 15 );
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



// Botões com função toggle



function toggleButton() {
	var $this = jQuery( this ),
		htmlFor = this.dataset['for'],
		value = this.dataset['value'],
		group = this.dataset['group'],
		$target = jQuery( '#' + htmlFor ),
		$groupButtons = jQuery( 'button[data-group="' + group + '"]' );
	if ( $this.hasClass('ativo') )
		return;
	$target.val( value );
	$groupButtons.removeClass('ativo');
	$this.addClass('ativo');
}

jQuery( function() {
	jQuery('button.button-toggle').click( toggleButton );
} );



// CSS para IE <= 8



jQuery( function() {
	if ( /MSIE [6-8]/.test( navigator.userAgent ) ) {
		jQuery( document.body ).addClass('ie-legacy');
		//jQuery.support.cors = true;
	}
});