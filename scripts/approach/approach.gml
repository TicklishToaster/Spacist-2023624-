/// @description Approach(start, end, shift);
/// @param start
/// @param end
/// @param shift
function Approach(arg_start, arg_end, arg_shift) {
	if (arg_start < arg_end)
	    return min(arg_start + arg_shift, arg_end); 
	else
	    return max(arg_start - arg_shift, arg_end);
}
