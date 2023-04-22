///@desc on open

//inherit the parent event
event_inherited();

//create slots

//ex_ui_slot_create_grid(id, obj_inv_slot, 5, box_size);
//ex_ui_slot_create_grid(id, obj_inv_slot, 10, box_size,
//	sprite_get_width(spr_slot_selected)/2 + slot_offset,
//	sprite_get_height(spr_slot_selected)/2 + slot_offset + 92 - 92);
ex_ui_slot_create_grid(id, obj_inv_slot, 10, box_size,
	//sprite_get_width(spr_slot_selected) * 0.5 + slot_offset,
	//sprite_get_height(spr_slot_selected) * 1.5 + slot_offset);
	16,
	16 + sprite_get_height(spr_slot_selected));