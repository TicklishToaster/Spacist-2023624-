///@desc on open

//inherit the parent event
event_inherited();

//var box_size = 80;

// Create slots.
ex_ui_slot_create_grid(id, obj_inv_slot, 10, box_size, 16, 16);

//set the first slot as selected
selected_slot = slots[0];