/// @description adjust_physics_vars(target, max_x_speed, max_y_speed, grav_rise, grav_fall, air_accel, air_fric);
/// @param target
/// @param max_x_speed
/// @param max_y_speed
/// @param grav_rise
/// @param grav_fall
/// @param air_accel
/// @param air_fric
function adjust_physics_vars(target, new_x_speed, new_y_speed, new_grav_rise, new_grav_fall, new_air_accel, new_air_fric) {
	var m = target.m;
	target.max_x_speed	= new_x_speed * m;
	target.max_y_speed	= new_y_speed * m;
	target.grav_rise	= new_grav_rise * m;
	target.grav_fall	= new_grav_fall * m;
	target.air_accel	= new_air_accel * m;
	target.air_fric		= new_air_fric  * m;	
}