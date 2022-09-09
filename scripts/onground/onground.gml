/// @description  OnGround();
function OnGround() {

	//return place_meeting(x, y + 1, oParSolid);
	return place_meeting(x, y + 1, obj_parent_solid);

}
