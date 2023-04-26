
var sort_list = false
for (var i = 0; i < ex_inv_size(inv_building); ++i) {
	if (ex_item_get_amount(inv_building, i) <= 0) {
		sort_list = true;
		var target_index = i;
		break;
	}
}
if (sort_list) { 
	ex_inv_sort(inv_building, EX_COLS.index, true);
	ds_list_delete(item_instance.item_list, target_index);
}