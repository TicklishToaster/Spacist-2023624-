// Sprite variables.
image_xscale = 4;
image_yscale = 4;
sprite_idle			= spr_constructor_idle;
sprite_active		= spr_constructor_active;
sprite_belt_exit	= spr_constructor_belt_exit;
sprite_belt_holder	= spr_constructor_belt_holder;
sprite_misc			= noone;

animation_frame		= 0;
animation_frame_max = sprite_get_number(sprite_active);
active_mode = false;


// Initialise building inventory.
inv_building		= ex_inv_create(2);
inv_building_ui		= obj_inv_panel_building;
inv_open			= false;
//ex_item_add(inv_building, "resource_iron_ore", 2, 0);


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

//// Create connection entrance/exit objects to be linked with conveyor belts.
//connection_entrance = instance_create_layer(x-(sprite_width/2)*1, y, "Logistics", obj_building_connector, {depth : depth+1, connection_point : 1});
//connection_exit		= instance_create_layer(x+(sprite_width/2)*0, y, "Logistics", obj_building_connector, {depth : depth+1, connection_point : 2});

// Initialise connecting input and output conveyor belt holders.
target_conveyor_input = noone;
target_conveyor_output= noone;

// Activity variables.
active_mode		= false;
recipe_timer	= 0;
