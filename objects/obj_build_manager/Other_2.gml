/// @description Insert description here
// You can write your code in this editor

var offset_x = sprite_get_width(spr_inventory_refinery) + sprite_get_width(spr_inventory_single) + 64;
var offset_x = sprite_get_width(spr_inventory_refinery)*2 + 32;
var offset_x = display_get_gui_width() - sprite_get_width(spr_inventory_single);
var increment = sprite_get_width(spr_inventory_single);
//var sprite_list = [
//	spr_smelter_full, spr_constructor_full, spr_assembler_full, spr_foundry_full, spr_container_full,
//	spr_conveyor_belt, spr_conveyor_tube, spr_conveyor_splitter, spr_platform_top
//];
var building_list = [
	// Key								Name					Sprite Icon						Instance ID				Sprite ID				9Slice
	["building_smelter",				"Smelter",				[spr_building_industry,  0],	obj_smelter,			spr_smelter_full,		false], 
	["building_constructor",			"Constructor",			[spr_building_industry,  1],	obj_constructor,		spr_constructor_full,	false], 
	//["building_foundry",				"Foundry",				[spr_building_industry,  2],	obj_constructor,		spr_foundry_full,		false], 
	//["building_assembler",				"Assembler",			[spr_building_industry,	 3],	obj_constructor,		spr_assembler_full,		false],
	["building_conveyor_belt_mk1",		"Conveyor Belt",		[spr_building_logistics, 0],	obj_conveyor_belt,		spr_conveyor_belt,		true ], 
	["building_conveyor_tube_mk1",		"Conveyor Tube",		[spr_building_logistics, 1],	obj_conveyor_tube,		spr_conveyor_tube,		false], 
	//["building_conveyor_splitter",		"Conveyor Splitter",	[spr_building_logistics, 2],	obj_conveyor_belt,		spr_conveyor_splitter,	false], 
	["building_raised_platform_mk1",	"Raised Platform",		[spr_building_logistics, 3],	obj_platform,			spr_raised_platform,	true ], 
	["building_storage_container_mk1",	"Storage Container",	[spr_building_logistics, 4],	obj_storage_container,	spr_container_full,		false]
];

for (var i = 0; i < 6; ++i) {
	instance_create_layer(offset_x + increment*0, increment*i, "Instances", obj_building_button, {
		building_key	: building_list[i][0],
		building_name	: building_list[i][1],
		building_icon	: building_list[i][2],
		building_id		: building_list[i][3],
		building_sprite	: building_list[i][4],
		building_9slice	: building_list[i][5]
	});
}

instance_deactivate_object(obj_building_button);


var resource_list = [
	// Key								Name					Sprite Icon						Instance ID				Sprite ID				9Slice
	["resource_limestone_chunk",		"Limestone Chunk",		[spr_resource_raw, 0],			obj_smelter,			spr_smelter_full,		false], 
	["resource_copper_ore",				"Copper Ore",			[spr_resource_raw, 1],			obj_constructor,		spr_constructor_full,	false], 
	["resource_iron_ore",				"Iron Ore",				[spr_resource_raw, 2],			obj_constructor,		spr_foundry_full,		false], 
	["resource_steel_debris",			"Steel Debris",			[spr_resource_raw, 3],			obj_constructor,		spr_assembler_full,		false],
	["resource_bauxite_chunk",			"Bauxite Chunk",		[spr_resource_raw, 4],			obj_conveyor_belt,		spr_conveyor_belt,		true ], 
	["resource_titanium_debris",		"Titanium Debris",		[spr_resource_raw, 5],			obj_conveyor_tube,		spr_conveyor_tube,		false], 
	["resource_gold_ore",				"Gold Ore",				[spr_resource_raw, 6],			obj_conveyor_belt,		spr_conveyor_splitter,	false], 
	["resource_coal_chunk",				"Coal Chunk",			[spr_resource_raw, 7],			obj_platform,			spr_raised_platform,	true ]
];

for (var i = 0; i < 8; ++i) {
	instance_create_layer(offset_x + increment*0, increment*i, "Instances", obj_resource_button, {
		resource_key	: resource_list[i][0],
		resource_name	: resource_list[i][1],
		resource_icon	: resource_list[i][2],
		//building_id		: building_list[i][3],
		//building_sprite	: building_list[i][4],
		//building_9slice	: building_list[i][5]
	});
}

instance_deactivate_object(obj_resource_button);
