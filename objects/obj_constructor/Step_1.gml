// Animation
animation_speed		= room_speed / 60 / 2;
animation_frame		= clamp(animation_frame + animation_speed, 0, animation_frame_max);

if (animation_frame >= animation_frame_max) {
	animation_frame = 0;
}

// Reset connecting conveyor belt holders if instances no longer exist.
if (!instance_exists(target_conveyor_input)) {
	target_conveyor_input = noone;
}
if (!instance_exists(target_conveyor_output)) {
	target_conveyor_output = noone;
}