var temp;

// Check if you were grounded previous frame
temp = grounded;

grounded = place_meeting(x, y + 1, obj_parent_solid);

// Update Hotspot (Center of Player Sprite)
hotspot_x = x + sprite_width/2;
hotspot_y = y + sprite_height/2;
