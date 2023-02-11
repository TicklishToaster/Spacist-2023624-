// Update Hotspot (Center of Hook Sprite)
hotspot_x = x;
hotspot_y = y;


// Update Room Wrap Location (If Hook Leaves Room Boundaries)
if (x > 0 && x < room_width) {
	room_wrap_x = 0;
}
else if (x < 0) {
	room_wrap_x = +room_width;
}
else if (x > room_width) {
	room_wrap_x = -room_width;
}

//// Update Room Wrap Location (If Hook Leaves Room Boundaries)
//if (x < 0) {
//	room_wrap_x = room_width;
//}
//if (x > room_width) {
//	room_wrap_x = -room_width;
//}