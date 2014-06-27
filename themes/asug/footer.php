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
				'instagram',
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
				<?php /*
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
				*/
				wp_nav_menu( array(
				  'menu' => 'top_menu',
				  'depth' => 2,
				  'container' => false,
				  'menu_class' => 'nav navbar-nav',
				  //Process nav menu using our custom nav walker
				  'walker' => new wp_bootstrap_navwalker()
				) );
				?>
			</div>
			<div class="copyright">
				<p><?php print wptexturize( $asug_opcoes['copyright'] ) ?></p>
			</div>
		</div>
	</footer>
	
</div><!-- #janela -->

<?php wp_footer(); ?>

</body>
</html>