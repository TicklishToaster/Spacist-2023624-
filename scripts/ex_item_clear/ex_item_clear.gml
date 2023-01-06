///@func	ex_item_clear(inv, slot)
///@desc	clears the contents of a slot
///@arg		{number} inv - inventory
///@arg		{number} slot - slot index to clear
function ex_item_clear(argument0, argument1) {

	var _inv = argument0;
	var _slot = argument1;

	//clear the slot
	_ex_fn_item_clear(_inv, _slot);

	//fire notification
	ex_ev_notify(_inv, EX_EVENTS.inv_updated);



}
