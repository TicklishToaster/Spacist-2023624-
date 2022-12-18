// Global Variable Lever //////////////////////////////////////////////////////
m = 1;

// Movement Vars //////////////////////////////////////////////////////////////
x_speed = 0;
y_speed = 0;

max_x_speed	= 5.5  * m;
max_y_speed	= 9.0  * m;

jump_height	= 10.0 * m;
jump_release_timer = 0;

grounded	= false;
grounded_ypos = 0;

grav_rise	= 0.10 * m; // 0.2 * 0.5 * m;
grav_fall	= 0.10 * m; // 0.2 * 0.5 * m;

// Acceleration & Friction Vars ///////////////////////////////////////////////
ground_accel = 1.00 * m;
ground_fric  = 2.00 * m;
air_accel    = 0.75 * m;
air_fric     = 0.10 * m;

// Grapple Vars ///////////////////////////////////////////////////////////////
grapple_mode = false;
grapple_mode_height = 1024 + 512;

// Sprite Vars ////////////////////////////////////////////////////////////////
player_idle = spr_player_idle;
player_walk = spr_player_walk;
player_jump = spr_player_jump;
player_rope = spr_player_rope;

animation_id = player_idle;
animation_index = 0;
animation_index2 = 0;

jumped = false;
jump_cancel = false;

// Misc ///////////////////////////////////////////////////////////////////////
hotspot_x = x + sprite_width;
hotspot_y = y + sprite_height;


///////////////////////////////////////////////////////////////////////////////