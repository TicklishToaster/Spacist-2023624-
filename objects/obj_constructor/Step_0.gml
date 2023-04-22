/// @description Insert description here
// You can write your code in this editor

if (keyboard_check_pressed(vk_space) && connection_exit != noone) {
	//ex_item_move(inv_building, 0, connection_exit.target_conveyor.inv_building, -1);
	ex_item_add(connection_exit.target_conveyor.inv_building, "resource_iron_plate", 2, -1);
}