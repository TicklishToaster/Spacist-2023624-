// Draw player
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);

// Draw instructions
draw_set_font(fntInstructions);
draw_set_color(c_white);
draw_text(__view_get( e__VW.XView, 0 )+5,__view_get( e__VW.YView, 0 )+2,string_hash_to_newline("Arrows - move/jump"));
draw_text(__view_get( e__VW.XView, 0 )+5,__view_get( e__VW.YView, 0 )+32,string_hash_to_newline("R - restart"));

