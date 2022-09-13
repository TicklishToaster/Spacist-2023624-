//if (instance_exists(obj_player)) {
//        // Make sure player is inside box
//        x = max(obj_player.x - sprite_width  * 0.5 + 0, min(x, obj_player.x + (sprite_width  * 0.5 - 8)));
//        y = max(obj_player.y - sprite_height * 0.5 + 8, min(y, obj_player.y + (sprite_height * 0.5 - 8)));

//        // Approach      
//        __view_set( e__VW.XView, 0, Approach(__view_get( e__VW.XView, 0 ), x - __view_get( e__VW.WPort, 0 ) * 0.5, 10) );
//        __view_set( e__VW.YView, 0, Approach(__view_get( e__VW.YView, 0 ), y - __view_get( e__VW.HPort, 0 ) * 0.5 - 16, 10) );
		
                
//        // Make sure camera is inside room
//        __view_set( e__VW.XView, 0, max(0, min(__view_get( e__VW.XView, 0 ), room_width  - __view_get( e__VW.WPort, 0 ))) );
//        __view_set( e__VW.YView, 0, max(0, min(__view_get( e__VW.YView, 0 ), room_height - __view_get( e__VW.HPort, 0 ))) );      
//}

//// Screenshake
//if (screenShake) {
//    __view_set( e__VW.Angle, 0, random_range(-1, 1) );
//} else {
//    // Reset
//    __view_set( e__VW.Angle, 0, 0 );
//}

//// Follow Target
//if instance_exists(target){
//	camera_X = target.x - (camera_width/2);
//	camera_Y = target.y - (camera_height/2);
	
//	camera_X = clamp(camera_X, 0, room_width-camera_width);
//	camera_Y = clamp(camera_Y, 0, room_height-camera_height);
//}

//// Set Camera Pos
//camera_set_view_pos(view_camera[0], camera_X, camera_Y);

//// Trigger Camera Shake
//camera_X += random_range(-camera_shake, camera_shake);
//camera_Y += random_range(-camera_shake, camera_shake);

//if camera_shake > 0 {
//	camera_shake -= 0.2;
//	if camera_shake < 0 {camera_shake = 0;}
//}