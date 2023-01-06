///@func	ex_item_get_amount(inv, slot)
///@desc	returns the amount at the given slot index
///@arg		{number} inv - inventory
///@arg		{number} slot - slot index
///@return	{number}
function ex_item_get_amount(argument0, argument1) {

	return _ex_fn_item_get(argument0, argument1, EX_COLS.amount);


}
