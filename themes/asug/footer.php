<?php
/**
 * The template for displaying the footer
 *
 * Contains footer content and the closing of the #main and #page div elements.
 *
 * @package WordPress
 * @subpackage Twenty_Twelve
 * @since Twenty Twelve 1.0
 */
?>
		</div><!-- #main .wrapper -->
	</div><!-- #page -->
	
	<div id="social">
		<p>Acompanhe-nos nas redes sociais</p>
		<ul>
			<?php
			// Para alterar, veja no admin Aparência -> Configurações
			global $asug_opcoes_config, $asug_opcoes;
			$redesSociais = array(
				'facebook',
				'twitter',
				'linkedin',
				'yahoo',
				'windows',
				'orkut',
			);
			foreach ( $redesSociais as $nome ) {
				$h = esc_attr( $asug_opcoes[ $nome ] );
				if ( !$h )
					continue;
				$t = esc_attr( $asug_opcoes_config[ $nome ]['title'] );
				print "\n\t\t\t<li class='$nome'><a href='$h' target='_blank' title='$t'>$t</a></li>";
			}
			?>
		</ul>
	</div>
	
	<footer>
		<div class="padrao">
			<div class="navbar">
				<ul class="nav navbar-nav">
					<li><a href="">Home</a></li>
					<li><a href="">Institucional</a></li>
					<li><a href="">Associe-se</a></li>
					<li><a href="">Grupo de estudo</a></li>
					<li><a href="">ABSG</a></li>
					<li><a href="">DRQ</a></li>
					<li><a href="">Fórum</a></li>
					<li><a href="">Conferência anual</a></li>
					<li><a href="">Impact Awards</a></li>
					<li><a href="">ASUG Day</a></li>
					<li><a href="">ASUG News</a></li>
				</ul>
			</div>
			<div class="copyright">
				<p>ASUG Brasil - Associção dos Usuários SAP do Brasil © 2014 | <a href="#">TERMOS DE USO</a></p>
			</div>
		</div>
	</footer>
	
</div><!-- #janela -->

<?php wp_footer(); ?>

</body>
</html>