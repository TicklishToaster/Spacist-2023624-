// Grapple Animation
img_index = clamp(img_index + img_speed, 0, 3.9);

if (object_attached == 0 && img_index >= 3.9) {
	img_index = 0;
	img_speed = 0;
}
else if (object_attached != 0 && img_index >= 3.9) {
	img_speed = 0;
}