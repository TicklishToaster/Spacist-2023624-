// Initialise building inventory.
inv_building		= ex_inv_create(40);
inv_building_ui		= obj_inv_panel_refinery;
inv_open			= false;
ex_item_add(inv_building, "resource_limestone_chunk",	64, -1);
ex_item_add(inv_building, "resource_copper_ore",		64, -1);
ex_item_add(inv_building, "resource_iron_ore",			64, -1);
ex_item_add(inv_building, "resource_steel_debris",		64, -1);
ex_item_add(inv_building, "resource_bauxite_chunk",		64, -1);
ex_item_add(inv_building, "resource_titanium_debris",	64, -1);
ex_item_add(inv_building, "resource_gold_ore",			64, -1);
ex_item_add(inv_building, "resource_coal_chunk",		64, -1);