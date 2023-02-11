// Movement Vars //////////////////////////////////////////////////////////////
x_speed = 0;
y_speed = 0;

//max_x_speed	= 5.500 * m; // 5.5
max_x_speed	= 10.00; // 5.5
max_y_speed	= 10.00; // 9.0

grav_rise	= 0.00;
grav_fall	= 0.00;

// Acceleration & Friction
air_accel	= 0.75;
air_fric	= 0.01;

// States /////////////////////////////////////////////////////////////////////
launch_physics	= [10.00, 10.00, 0.00, 0.00, 0.75, 0.00];
approach_physics= [2.000, 2.000, 0.10, 0.00, 0.75, 0.03];
move_physics	= [2.000, 2.000, 0.10, 0.00, 0.75, 0.10];
fall_physics	= [10.00, 20.00, 0.00, 0.00, 0.75, 0.00];
//grounded_physics= [0.00, 0.000, 0.00, 0.00, 0.00, 0.00];

state_launched		= true;
state_controlled	= false;
state_pulling		= false;
state_retrieving	= false;

// Sprite Vars ////////////////////////////////////////////////////////////////
img_index = 0;
img_speed = 0;
img_rot = 0;
lock_rot = 0;

hotspot_x = x;
hotspot_y = y;
room_wrap_x = 0;
return_angle = 0;

// Misc ///////////////////////////////////////////////////////////////////////
attached_object = noone;

horizontal_limit = obj_camera.camera_width/2 + obj_camera.camera_width/2;
horizontal_distance = 0;
horizontal_origin = 0;

// Set lower depth so object is drawn in front of rope and asteroids.
depth = -110;

// Physics Settings Method
set_phys = function(phys) {
	max_x_speed	= phys[0];
	max_y_speed	= phys[1];
	grav_rise	= phys[2];
	grav_fall	= phys[3];
	air_accel	= phys[4];
	air_fric	= phys[5];
}