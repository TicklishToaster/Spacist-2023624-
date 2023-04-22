
///@arg building key
function select_building(building_key) {
	var building_id		 = noone;
	var building_sprite	 = -1;
	//var building_sprite_misc1	= spr_smelter_belt_exit;
	//var building_sprite_misc2	= spr_smelter_belt_holder;
	var stretch_placement = false;
		
	switch (building_key) {
		case "building_smelter":
			building_id		= obj_smelter;
			building_sprite	= spr_smelter_full;
			//building_sprite_misc1	= spr_smelter_belt_exit;
			//building_sprite_misc2	= spr_smelter_belt_holder;
		    break;
		case "building_constructor":
			building_id		= obj_constructor;
			building_sprite	= spr_constructor_full;
			//building_sprite_misc1	= spr_constructor_belt_exit;
			//building_sprite_misc2	= spr_constructor_belt_holder;			
		    break;
		case "building_conveyor_belt_mk1":
			building_id		= obj_conveyor_belt;
		    building_sprite	= spr_conveyor_belt;
			stretch_placement = true;
		    break;
		default:
		    //sprite_active	= noone;
			//building_sprite		= noone;
		    break;
	}
	return [building_id, building_sprite, stretch_placement];
	//return [building_id, building_sprite, [building_sprite_misc1, building_sprite_misc2], stretch_placement];
}