// Misc ///////////////////////////////////////////////////////////////////////
hook_parent = 0;
hook_attached = false;
state_grounded = false;

if (sprite_index == spr_asteroid_02) {
	weight = 2;
}
else {
	weight = 1;	
}
	
if variable_struct_exists(self, "size") {
	image_xscale = size;
	image_yscale = size;
}

if variable_struct_exists(self, "row_direction") {
	if (row_direction % 2 == 0) {
		row_direction = 1;
	}
	else {
		row_direction = -1;
	}
}

//sprite_index = choose(spr_asteroid_02, spr_asteroid_03, spr_asteroid_04);