
///@arg building key
function select_building(building_key) {
	var building_id		 = noone;
	var building_sprite	 = -1;
	var building_9slice  = false
		
	switch (building_key) {
		case "building_smelter":
			building_id		= obj_smelter;
			building_sprite	= spr_smelter_full;
		    break;
		case "building_constructor":
			building_id		= obj_constructor;
			building_sprite	= spr_constructor_full;		
		    break;
		case "building_foundry":
			building_id		= obj_constructor;
			building_sprite	= spr_foundry_full;
		    break;
		case "building_assembler":
			building_id		= obj_constructor;
			building_sprite	= spr_assembler_full;
		    break;
		case "building_conveyor_belt_mk1":
			building_id		= obj_conveyor_belt;
		    building_sprite	= spr_conveyor_belt;
			building_9slice = true;
		    break;
		case "building_conveyor_tube_mk1":
			building_id		= obj_conveyor_belt;
		    building_sprite	= spr_conveyor_tube;
			building_9slice = true;
		    break;
		case "building_conveyor_splitter":
			building_id		= obj_conveyor_belt;
		    building_sprite	= spr_conveyor_splitter;
		    break;
		case "building_raised_platform_mk1":
			building_id		= obj_conveyor_belt;
		    building_sprite	= spr_platform_top;
			building_9slice = true;
		    break;
		case "building_storage_container_mk1":
			building_id		= obj_conveyor_belt;
		    building_sprite	= spr_container_full;
		    break;
	}
	return [building_id, building_sprite, building_9slice];
}