// Increment pann_coefficient using pann_speed.
if (state_panning) {
	pann_coefficient = clamp(pann_coefficient + pann_speed, 0.00, 1.00);
}

// Disable panning when pann_coefficient is at max.
if (pann_coefficient >= 1.00) {
	state_panning = false;
	pann_coefficient = 0.00;
	show_debug_message("PANN STOP");
}

