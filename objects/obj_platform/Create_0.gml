//// Inherit the parent event
//event_inherited();

// Sprite variables.
image_xscale = 4;
image_yscale = 4;
sprite_idle		= spr_raised_platform;
sprite_active	= spr_platform_top;
sprite_misc		= spr_platform_support;

// Initialise conveyor inventory.
inv_building		= ex_inv_create(1);
//inv_building		= ex_inv_create(1);
inv_building_ui		= obj_inv_panel_conveyor;
inv_open			= false;

//platform_width	= 1;
//platform_height = 1;
