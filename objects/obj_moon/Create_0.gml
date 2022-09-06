// Settings (changeable)
planetRadius = sprite_width/2 // set planet size
fric = 0.995; // friction applied when planets collide (between 0-1)
force = 0.15; // force applied when planets collide
maxSpd = 12; // planet maximum speed
startSpd = 0; // starting speed for planets

// Set mass (using the radius)
mass = planetRadius/100;

// Movement
xSpd = 0;
ySpd = 0;