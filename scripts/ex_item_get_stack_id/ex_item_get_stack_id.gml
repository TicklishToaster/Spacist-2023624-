///@func	ex_item_get_stack_id(inv, slot)
///@desc	returns the stack_id at the given slot index
///@arg		{number} inv - inventory
///@arg		{number} slot - slot index
///@return	{string}
function ex_item_get_stack_id(argument0, argument1) {

	return _ex_fn_item_get(argument0, argument1, EX_COLS.stack_id);



}
