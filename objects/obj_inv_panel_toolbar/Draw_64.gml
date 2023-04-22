//inherit the parent event
event_inherited();

//draw the selected slot outline
if (selected_slot != noone) {
	with (selected_slot) {
		draw_sprite(spr_slot_selected, 0, x-8, y-8);
	}
}