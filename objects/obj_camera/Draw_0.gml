// Recreate Surfaces //////////////////////////////////////////////////////////
// In the event of a memory leak or buffer, recreate surfaces.
if !surface_exists(popup_window_surface) {
	popup_window_surface = surface_create(320, 320);
	view_surface_id[1] = popup_window_surface;	
}

// Set Up & Draw Surfaces /////////////////////////////////////////////////////
if (target.y < obj_player.grapple_camera_height) {
	// Set the target surface to draw onto.
	surface_set_target(popup_window_surface);

	// Disable some GPU stuff I don't understand.
	gpu_set_blendenable(false)
	gpu_set_colorwriteenable(false,false,false,true);

	// Draw the rectangular border with 0.0 alpha blending (invisible borders).
	draw_set_alpha(0);
	draw_rectangle(0, 0, 320, 320, false);
	draw_set_alpha(1);
	
	// Draw the circular window with 0.8 alpha blending (almost opaque center).
	draw_set_alpha(0.8);
	draw_circle(160, 160, 160, false);
	draw_set_alpha(1);
	
	// Re-enable the GPU stuff I don't understand.
	gpu_set_blendenable(true);
	gpu_set_colorwriteenable(true,true,true,true);
   
	// Reset the target surface, to the game can go back to drawing everything else normally.
	surface_reset_target();

	// Draw Surface (Popup Window)
	if (view_visible[1] && view_current == 0) {
		draw_surface(popup_window_surface, camera_x, camera_y+camera_height-view_hport[1])
	}	
}