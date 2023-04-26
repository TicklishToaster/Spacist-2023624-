/// @description Destroy Asteroid Field
// Destroy all objects in the asteroid layer except the one retreived.
with (obj_asteroid) {
	if (!state_returning) {
		instance_destroy();
	}
}