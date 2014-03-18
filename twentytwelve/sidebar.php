<?php
/**
 * The sidebar containing the main widget area
 *
 * If no active widgets are in the sidebar, hide it completely.
 *
 * @package WordPress
 * @subpackage Twenty_Twelve
 * @since Twenty Twelve 1.0
 */
?>

				
					<div id="eventos">
						<h3>Eventos</h3>
						 <?php wp_reset_query(); ?>
							<?php echo TCHPCSCarousel(); ?>
					</div>
				