// Free post-processing system from memory
for (var i = 0; i < array_length(ppfx_ids); i++) {
	ppfx_destroy(ppfx_ids[i]);
}

// Destroy created post-processing layer
for (var i = 0; i < array_length(ppfx_layer_ids); i++) {
	ppfx_layer_destroy(ppfx_layer_ids[i]);
}
