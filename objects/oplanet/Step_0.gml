// Limit speed
xSpd = min(max(xSpd,-maxSpd),maxSpd);
ySpd = min(max(ySpd,-maxSpd),maxSpd);

// Move position
x += xSpd;
y += ySpd;

// Move player with it if player is on this planet
if oPlayer.onPlanet && oPlayer.planet = id {
    oPlayer.x += xSpd;
    oPlayer.y += ySpd;
}

// Collide with other planets
with(oPlanet) {
    if id != other.id {
        if point_distance(x,y,other.x,other.y) < planetRadius+other.planetRadius {
            // Find collide point
            pDir = point_direction(x,y,other.x,other.y);
            x1 = x+lengthdir_x(planetRadius,pDir);
            y1 = y+lengthdir_y(planetRadius,pDir);
            x2 = other.x+lengthdir_x(other.planetRadius,pDir-180);
            y2 = other.y+lengthdir_y(other.planetRadius,pDir-180);
            midX = (x1+x2)/2;
            midY = (y1+y2)/2;
            // Change the position and speed
            x = midX+lengthdir_x(planetRadius,pDir-180);
            y = midY+lengthdir_y(planetRadius,pDir-180);
            other.x = midX+lengthdir_x(other.planetRadius,pDir);
            other.y = midY+lengthdir_y(other.planetRadius,pDir);
            xSpd *= fric;
            ySpd *= fric;
            other.xSpd *= fric;
            other.ySpd *= fric;
            xSpd += lengthdir_x(force,pDir-180);
            ySpd += lengthdir_y(force,pDir-180);
        }
    }
}

// Fade color
if oPlayer.onPlanet {
    if oPlayer.planet = id {
        fade = lerp(fade,1,0.15);
    }
    else {
        fade = lerp(fade,0,0.15);
    }
}
else {
    fade = lerp(fade,0,0.15);
}

