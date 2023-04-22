// Inherit the parent event
event_inherited();

sprite_idle			= spr_smelter_idle;
sprite_active		= spr_smelter_active;
sprite_belt_exit	= spr_smelter_belt_exit;
sprite_belt_holder	= spr_smelter_belt_holder;
sprite_misc			= noone;


// Initialise building inventory.
inv_building		= ex_inv_create(2);
inv_building_ui		= obj_inv_panel_building;
inv_open			= false;
ex_item_add(inv_building, "resource_iron_bolt", 2, 0);


// Create belt exit and belt holder sprite instances.
belt_instance1 = instance_create_layer(x, y, "Industry_Belt_Exit", obj_industry_layer, 
	{creator : id, sprite_index : sprite_belt_exit, image_xscale : image_xscale, image_yscale : image_yscale});
belt_instance2 = instance_create_layer(x, y, "Industry_Belt_Holder", obj_industry_layer, 
	{creator : id, sprite_index : sprite_belt_holder, image_xscale : image_xscale, image_yscale : image_yscale});


// Create connection entrance/exit objects to get linked conveyor belts.
connection_entrance = instance_create_layer(x-(sprite_width/2)*1, y, "Logistics", obj_building_connector, 
	{creator : id, connection_type : "input",  depth : depth+1});
connection_exit		= instance_create_layer(x+(sprite_width/2)*0, y, "Logistics", obj_building_connector, 
	{creator : id, connection_type : "output", depth : depth+1});


// Initialise connecting input and output conveyor belt holders.
target_conveyor_input = noone;
target_conveyor_output= noone;

//222
active_mode		= false;
recipe_timer	= 0;


