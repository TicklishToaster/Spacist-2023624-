// Randomize
randomize();

// Settings (changeable)
planetRadius = choose(75,100,125,150,175,200,225); // choose random planet size
fric = 0.995; // friction applied when planets collide (between 0-1)
force = 0.15; // force applied when planets collide
maxSpd = 12; // planet maximum speed
startSpd = 0.15; // starting speed for planets

// Set mass (using the radius)
mass = planetRadius/100;

// Movement
xSpd = random_range(-startSpd,startSpd);
ySpd = random_range(-startSpd,startSpd);

// Colors
r = 100;
g = 100;
b = 100;
r2 = 190;
g2 = 40;
b2 = 30;
fade = 0;

