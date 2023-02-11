/// @description Lerp Panning Coefficient

//panning_lerp_co = clamp(panning_lerp_co + 0.01, 0.00, 1.00);
//if (panning_lerp_co >= 0.10) {
//	panning_lerp_co = clamp(panning_lerp_co + 0.02, 0.00, 1.00);
//	//panning_lerp_co = clamp(panning_lerp_co + 0.22, 0.00, 1.00);
//}

//if (panning_lerp_co < 1.0) {
//	alarm[0] = room_speed * 0.1;
//}


//if (state_panning_static) {
//	pann_coefficient = clamp(pann_coefficient + pann_speed, 0.00, 1.00);
//	if (pann_coefficient >= 0.10) {
//		//pann_coefficient = clamp(pann_coefficient + pann_speed, 0.00, 1.00);
//		//pann_coefficient = clamp(pann_coefficient + 0.22, 0.00, 1.00);
//	}

//}
//if (state_panning_dynamic) {
//	pann_coefficient = clamp(pann_coefficient + pann_speed, 0.00, 1.00);
	
//	pann_origin_x = pann_origin_object.hotspot_x;
//	pann_origin_y = pann_origin_object.hotspot_y;
//	pann_target_x = pann_target_object.hotspot_x;
//	pann_target_y = pann_target_object.hotspot_y;	
//	//pann_distance = point_distance(pann_origin_object.hotspot_x, pann_origin_object.hotspot_y, 
//	//							   pann_target_object.hotspot_x, pann_target_object.hotspot_y);
//}

//if (pann_coefficient < 1.00) {
//	show_debug_message(pann_coefficient)
//	alarm[0] = room_speed * 0.05;
//}
//else if (pann_coefficient >= 1.00) {
//	state_panning_static  = false;
//	state_panning_dynamic = false;
//	pann_coefficient = 0.00;
//	show_debug_message("PANN STOP");
//}

