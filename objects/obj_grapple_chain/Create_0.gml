aim_direction = point_direction(creator.grapple_origin_x, creator.grapple_origin_y, obj_hook.x, obj_hook.y);
chain_len = point_distance(x, y, obj_hook.x, obj_hook.y) / sprite_get_height(spr_chain)

// Set higher depth so object is drawn behind grapple launcher, but in front of asteroids.
depth = 100;
