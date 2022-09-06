// Gravity
if !onPlanet {
    near = -1;
    nearForce = -1;
    with(obj_moon) {
        pDist = point_distance(other.x, other.y, x, y);
        pDir = point_direction(other.x, other.y, x, y);
        if pDist-other.offset > planetRadius+1 { 
			// Apply gravity to player when in the air.
            force = (other.grav/(pDist*(pDist/2)))*mass;
			//force = (other.grav/(pDist*pDist))*mass;
            if force > other.nearForce {
                other.nearForce = force;
                other.near = id;
            }
            other.xSpd += lengthdir_x(force, pDir);
            other.ySpd += lengthdir_y(force, pDir);
        }
        else { 
			// Put player on surface.
            other.onPlanet = true;
            other.planet = id;
			
			//// This commented section allows the planet to be pushed by the player.
            //xSpd *= 0.75;
            //ySpd *= 0.75; 
            //spd = point_distance(0, 0, other.xSpd, other.ySpd);
            //pDir = point_direction(0, 0, other.xSpd, other.ySpd);
            //xSpd += lengthdir_x((spd/mass)*other.landForce, pDir);
            //ySpd += lengthdir_y((spd/mass)*other.landForce, pDir);
        }
    }
}

// If the player is far away from everything, gravitate to the nearest planet.
inst = instance_nearest(x, y, obj_moon);
//show_debug_message(point_distance(x, y, inst.x, inst.y))
if point_distance(x, y, inst.x, inst.y) > distLimit {
    xSpd *= 0.97;
    ySpd *= 0.97;
    pDir = point_direction(x, y, inst.x, inst.y);
    xSpd += lengthdir_x(0.6, pDir);
    ySpd += lengthdir_y(0.6, pDir);
}

// On Planet Surface
if onPlanet {
    pDir = point_direction(planet.x, planet.y, x, y);
    x = planet.x + lengthdir_x(planet.planetRadius+offset, pDir);
    y = planet.y + lengthdir_y(planet.planetRadius+offset, pDir);
    xSpd = 0;
    ySpd = 0;
}

// Rotate Player Image
if onPlanet {
    downDir = point_direction(x, y, planet.x, planet.y);
}
else {
    downDir = point_direction(x, y, near.x, near.y);
}
if onPlanet {
	// Instantly rotate sprite until it is perpendicular to the planet surface.
    image_angle -= angle_difference(image_angle, downDir+90) * 0.75;
}
else {
	// Slowly rotate sprite until it is perpendicular to the planet surface.
    image_angle -= angle_difference(image_angle, downDir+90) * turnSpd;
}

// Walk
if onPlanet {
    if keyboard_check(ord("A")) {
        xSpd = lengthdir_x(walkSpd, downDir-90);
        ySpd = lengthdir_y(walkSpd, downDir-90);
    }
    else if keyboard_check(ord("D")) {
        xSpd = lengthdir_x(walkSpd, downDir+90);
        ySpd = lengthdir_y(walkSpd, downDir+90);
    }
}
else {
	//downDir = image_angle - 90;
    if keyboard_check(ord("A")) {
        xSpd += lengthdir_x(airControl, downDir-90);
        ySpd += lengthdir_y(airControl, downDir-90);
		
		show_debug_message(lengthdir_x(airControl, downDir-90));
		show_debug_message(lengthdir_y(airControl, downDir-90));
		show_debug_message("========");
    }
    else if keyboard_check(ord("D")) {
        xSpd += lengthdir_x(airControl, downDir+90);
        ySpd += lengthdir_y(airControl, downDir+90);
		
		show_debug_message(lengthdir_x(airControl, downDir+90));
		show_debug_message(lengthdir_y(airControl, downDir+90));
		show_debug_message("========");
    }
}

// Jump
if onPlanet {
    if keyboard_check_pressed(vk_space) {
        onPlanet = false;
        pDir = point_direction(planet.x, planet.y, x, y);
        xSpd = lengthdir_x(jumpForce, pDir);
        ySpd = lengthdir_y(jumpForce, pDir);
        near = planet;
    }
}

// Move x/y
x += xSpd;
y += ySpd;

// Limit Speed
xSpd = min(max(xSpd, -maxSpd), maxSpd);
ySpd = min(max(ySpd, -maxSpd), maxSpd);
