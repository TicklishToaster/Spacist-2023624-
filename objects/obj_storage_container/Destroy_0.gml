/// @description Destroy layered objects
if (instance_exists(belt_instance1)) {
	instance_destroy(belt_instance1);
}
if (instance_exists(belt_instance2)) {
	instance_destroy(belt_instance2);
}

if (instance_exists(item_instance)) {
	instance_destroy(item_instance);
}