/// @description Insert description here
// You can write your code in this editor

object_spawn_chance = [
	["Asteroid",	80],
	["Debris",		20],
	["Curio",		00]
];

asteroid_spawn_pool = [
	// Object ID			Chance	Resource Pool																								Colour
	["Asteroid Type-C",		67,		["resource_limestone_chunk",30, 50], ["resource_coal_chunk",	20, 40], ["resource_copper_ore",	20, 40], make_color_rgb(255, 255, 255)],
	["Asteroid Type-S",		30,		["resource_limestone_chunk",20, 30], ["resource_iron_ore",		40, 60], ["resource_copper_ore",	40, 60], make_color_rgb(161, 157, 148)],
	["Asteroid Type-M",		03,		["resource_bauxite_chunk",	40, 60], ["resource_gold_ore",		10, 20], ["None",					00, 00], make_color_rgb(232, 185, 035)]
];

debris_spawn_pool = [
	// Object ID			Chance	Resource Pool
	["Debris Type-I",		60,		["resource_bauxite_chunk",	40, 60], ["resource_iron_ore",			50, 70], ["resource_copper_ore",40, 60], make_color_rgb(161, 157, 148)],
	["Debris Type-S",		35,		["resource_iron_ore",		60, 90], ["resource_steel_debris",		20, 40], ["None",				00, 00], make_color_rgb(135, 134, 129)],
	["Debris Type-T",		05,		["resource_steel_debris",	40, 60], ["resource_titanium_debris",	20, 30], ["None",				00, 00], make_color_rgb(255, 255, 255)]
];

curio_spawn_pool = [
	// Object ID			Chance	Resource Pool
	["Sample",				00,		["Chunk", 0], ["Chunk", 0]],
	["Sample",				00,		["Chunk", 0], ["Chunk", 0]],
	["Sample",				00,		["Chunk", 0], ["Chunk", 0]]
];

asteroid_info_data = [
//Chance	Sprite Index		Image Index Range							  Mass Scale Range Colour
	[35,	spr_asteroid_small,	[0, sprite_get_number(spr_asteroid_small)-1 ],	1, [0.8, 0.9], make_color_rgb(255, 200, 200)],
	[30,	spr_asteroid_medium,[0, sprite_get_number(spr_asteroid_medium)-1],	2, [0.9, 1.0], c_white],
	[30,	spr_asteroid_large,	[0, sprite_get_number(spr_asteroid_large)-1 ],	3, [0.9, 1.0], c_white],
	[00,	spr_asteroid_giant,	[0, sprite_get_number(spr_asteroid_giant)-1 ],	4, [1.0, 1.2], c_white]
];


debris_info_data = [
//Chance	Sprite Index		Image Index Range							  Mass Scale Range
	[35,	spr_debris_small,	[0, sprite_get_number(spr_debris_small)-1 ],	1, [0.8, 0.9], c_white],
	[30,	spr_debris_medium,	[0, sprite_get_number(spr_debris_medium)-1],	2, [0.9, 1.0], c_white],
	[30,	spr_debris_large,	[0, sprite_get_number(spr_debris_large)-1 ],	3, [0.9, 1.0], c_white],
	[00,	spr_debris_giant,	[0, sprite_get_number(spr_debris_giant)-1 ],	4, [0.1, 0.1], c_white]
];

object_spawn_data	= [asteroid_spawn_pool, debris_spawn_pool, curio_spawn_pool];
object_info_data	= [asteroid_info_data, debris_info_data];


//asteroid_spawn_pool = [
//	// Object ID			Chance	Resource Pool
//	["Asteroid Type-C",		67,		["Limestone Chunk", 30, 50], ["Coal Chunk",		 20, 40], ["Copper Ore",20, 40]],
//	["Asteroid Type-S",		30,		["Limestone Chunk", 20, 30], ["Iron Ore",		 40, 60], ["Copper Ore",40, 60]],
//	["Asteroid Type-M",		03,		["Bauxite Chunk",	40, 60], ["Gold Ore",		 10, 20], ["None",		00, 00]]
//];

//debris_spawn_pool = [
//	// Object ID			Chance	Resource Pool
//	["Debris Type-I",		60,		["Bauxite Chunk",	40, 60], ["Iron Ore",		 50, 70], ["Copper Ore",40, 60]],
//	["Debris Type-S",		35,		["Iron Ore",		60, 90], ["Steel Debris",    20, 40], ["None",		00, 00]],
//	["Debris Type-T",		05,		["Steel Debris",	40, 60], ["Titanium Debris", 20, 30], ["Chunk",		00, 00]]
//];