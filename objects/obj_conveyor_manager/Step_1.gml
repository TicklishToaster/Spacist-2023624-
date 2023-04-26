/// @description Animation 
animation_speed		= room_speed / 60 / 2 / 1;
animation_frame		= clamp(animation_frame + animation_speed, 0, animation_frame_max);

if (animation_frame >= animation_frame_max) {
	animation_frame = 0;
	//animation_frame = animation_frame_max;
}