///func		draw_building(sprite, layer, offset)
///@arg		building_sprite
///@arg		layer - building layer to place the structure on (-1, 0, 1)

function draw_building(building_sprite, building_layer = 0, building_offset = 0) {
	// Draw building in build mode.
	var snap_x = floor(mouse_x/ 32) * 32 + building_offset;
	var snap_y = room_height - 32 * 5 - sprite_get_height(building_sprite)*2 - 64 * building_layer;
	draw_sprite_ext(building_sprite, 0, snap_x, snap_y, 4, 4, 0, c_white, 0.7);
}