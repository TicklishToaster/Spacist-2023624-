//// Inherit the parent event
//event_inherited();

// Sprite variables.
image_xscale = 4;
image_yscale = 4;
sprite_idle		= spr_conveyor_tube;
sprite_active	= spr_conveyor_tube;
sprite_misc		= spr_conveyor_tube_background;


//// Create conveyor leg sprite instance.
//belt_instance1 = instance_create_layer(x + 32*4, y, "Logistics", obj_industry_layer, 
//	{creator : id, sprite_index : sprite_misc, image_xscale : image_xscale, image_yscale : image_yscale});
	
belt_instance2 = instance_create_layer(x + 32*4, y, "Logistics", obj_conveyor_belt);
with (belt_instance2) {
	connector_entrance = other.id;
}

// Create an instance of conveyor item to draw moving items over this conveyor belt.
item_instance = instance_create_layer(x, y, "Conveyor_Items", obj_conveyor_item, {creator : id, visible : false});

// Create connection point instances used to check and assign connecting building ids.
//connection_point_1 = instance_create_layer(x-(sprite_width/2)*1, y, "Logistics", obj_conveyor_connector, 
//	{depth : depth+1, connection_point : 1});
connection_point_2 = instance_create_layer(x+(sprite_width/2)*1, y, "Logistics", obj_conveyor_connector, 
	{depth : depth+1, connection_point : 2});

// Create placeholders to store the instance ids of connecting buildings.
//connector_entrance	= noone;
connector_exit			= belt_instance2;
//connector_building	= noone;
//connector_building_type = noone;

// Initialise conveyor inventory.
inv_building		= ex_inv_create(1);
inv_building_ui		= obj_inv_panel_conveyor;
inv_open			= false;
//ex_item_add(inv_building, "resource_iron_ore", 1, 0);

selection_active	= false;
target_resource_key = noone;