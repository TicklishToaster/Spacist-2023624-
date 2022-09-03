// Room speed
room_speed = 60;

// Settings
walkSpd = 4; // speed when walking
airControl = 0.2; // maneuverability when not on planet
maxSpd = 20; // maximum moving speed
jumpForce = 9; // jump height
grav = 6000; // gravity force
landForce = 0.2; // force applied to a planet when landing on it
distLimit = 800; // how far away the player can be to the nearest planet (when outside this radius, the player will accelerate towards it)
offset = sprite_height/2-1; // player sprite should be centered, so it needs an offset to not sink into the ground
turnSpd = 0.2; // how fast the player sprite turns (between 0-1)

// Movement
xSpd = 0;
ySpd = 0;
onPlanet = false;
planet = 0;
near = -1;

