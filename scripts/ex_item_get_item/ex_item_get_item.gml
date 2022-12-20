///@func	ex_item_get_item(inv, slot)
///@desc	returns the item data (as ds_map) at the given slot index, or -1 if no item is present
///@arg		{number} inv - inventory
///@arg		{number} slot - slot index
///@return	{ds_map|number}
function ex_item_get_item(argument0, argument1) {

	return _ex_fn_item_get(argument0, argument1, EX_COLS.item);




}
