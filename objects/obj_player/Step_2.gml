// Actual collision checks + movement
var i;

// Vertical
for (i = 0; i < abs(y_speed); ++i) {
    if (!place_meeting(x, y + sign(y_speed), obj_parent_solid))
        y += sign(y_speed);
    else {
        y_speed = 0;
        break;
    }
}

// Horizontal
for (i = 0; i < abs(x_speed); ++i) {
    // UP slope
    if (place_meeting(x + sign(x_speed), y, obj_parent_solid) && !place_meeting(x + sign(x_speed), y - 1, obj_parent_solid))
        --y;
    
    // DOWN slope
    if (!place_meeting(x + sign(x_speed), y, obj_parent_solid) && !place_meeting(x + sign(x_speed), y + 1, obj_parent_solid) && place_meeting(x + sign(x_speed), y + 2, obj_parent_solid))
        ++y;      
        
    if (!place_meeting(x + sign(x_speed), y, obj_parent_solid))
        x += sign(x_speed); 
    else {
		x_speed = 0;
        break;
    }
}