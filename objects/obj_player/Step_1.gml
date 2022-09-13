var temp;

// Check if you were grounded previous frame
temp = grounded;

grounded = place_meeting(x, y + 1, obj_parent_solid);
