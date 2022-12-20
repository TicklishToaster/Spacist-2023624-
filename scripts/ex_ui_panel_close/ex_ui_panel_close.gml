///@func	ex_ui_panel_close(panel)
///@desc	closes the specified panel instance. If a panel object is passed instead of a specific instance, all instances of that object will be closed.
///@arg		{instance|object} panel - object or specific instance to close
function ex_ui_panel_close(argument0) {

	with(argument0) {
	    instance_destroy();
	}



}
