/// @description Destroy layered objects
if (belt_instance1 != noone) {
	instance_destroy(belt_instance1);
}
if (belt_instance2 != noone) {
	instance_destroy(belt_instance2);
}

if (item_instance != noone) {
	instance_destroy(item_instance);
}
///// @description Destroy layered objects
//if (instance_exists(belt_instance1) || belt_instance1 == noone) {
//	instance_destroy(belt_instance1);
//}
//if (instance_exists(belt_instance2 || belt_instance2 == noone)) {
//	instance_destroy(belt_instance2);
//}

//if (instance_exists(item_instance || item_instance == noone)) {
//	instance_destroy(item_instance);
//}