// Grapple Animation //////////////////////////////////////////////////////////
img_index = clamp(img_index + img_speed, 0, 4.9);

// If no object is attached and grapple animation finished, reverse animation.
if (!instance_exists(attached_object) && img_index >= 2.9) {
	img_speed = -0.10;
}

// If object is attached and grapple animation finished, stop animation.
if (instance_exists(attached_object) && img_index >= 4.9) {
	img_speed = 0;
	img_index = 4;
}
	