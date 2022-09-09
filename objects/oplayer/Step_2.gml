// Actual collision checks + movement
var i;

// Vertical
for (i = 0; i < abs(v); ++i) {
    if (!place_meeting(x, y + sign(v), oParSolid))
        y += sign(v);
    else {
        v = 0;
        break;
    }
}

// Horizontal
for (i = 0; i < abs(h); ++i) {
    // UP slope
    if (place_meeting(x + sign(h), y, oParSolid) && !place_meeting(x + sign(h), y - 1, oParSolid))
        --y;
    
    // DOWN slope
    if (!place_meeting(x + sign(h), y, oParSolid) && !place_meeting(x + sign(h), y + 1, oParSolid) && place_meeting(x + sign(h), y + 2, oParSolid))
        ++y;      
        
    if (!place_meeting(x + sign(h), y, oParSolid))
        x += sign(h); 
    else {
        // Push block
        if (place_meeting(x + sign(h), y, oPushBlock)) {
            with (instance_place(x + sign(h), y, oPushBlock))
                h = other.h
        } else
            h = 0;
        break;
    }
}

///////////////////////////////////////////////////////////////////////////////


// Update particle trail
ydrift = -sign(v);
xdrift = -sign(h);

if (abs(h) > abs(v)) {
    xscatter = 0;
    yscatter = 4;
} else {
    xscatter = 4;
    yscatter = 0;
}

// Standing
if (abs(v) < jumpHeight * 0.5)
if (h == 0) {
    xdrift = -sign(facing) * 5;
    ydrift = 0;
    if (v != 0)
        xdrift = -sign(facing) * 2;    
    xscatter = 0;
    yscatter = 2;
}

TrailUpdate(trail, x + facing, y + 2);
TrailDrift(trail, xdrift, ydrift);
TrailScatter(trail, xscatter, yscatter);

