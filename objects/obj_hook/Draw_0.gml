// Words
if (!state_falling) {
	img_rot = obj_rope.end_rotation;
} else {
	img_rot = lock_rot;
}

// Draw grapple at end rope joint.
draw_sprite_ext(sprite_index, img_index, x, y, 1, 1, img_rot+90, -1, 1);
