// Update Input Variables /////////////////////////////////////////////////////
// Input WASD Controls
input_up_press			= keyboard_check_pressed(ord("W"));
input_up_hold			= keyboard_check(ord("W"));
input_down_press		= keyboard_check_pressed(ord("S"));
input_down_hold			= keyboard_check(ord("S"));
input_left_press		= keyboard_check_pressed(ord("A"));
input_left_hold			= keyboard_check(ord("A"));
input_right_press		= keyboard_check_pressed(ord("D"));
input_right_hold		= keyboard_check(ord("D"));

// Input Arrow Key Controls
input_uparrow_press		= keyboard_check_pressed(vk_up);
input_uparrow_hold		= keyboard_check(vk_up);
input_downarrow_press	= keyboard_check_pressed(vk_down);
input_downarrow_hold	= keyboard_check(vk_down);
input_leftarrow_press	= keyboard_check_pressed(vk_left);
input_leftarrow_hold	= keyboard_check(vk_left);
input_rightarrow_press	= keyboard_check_pressed(vk_right);
input_rightarrow_hold	= keyboard_check(vk_right);

// Input Mouse Controls
input_mouse1_click		= mouse_check_button_pressed(mb_left);
input_mouse1_hold		= mouse_check_button(mb_left);
input_mouse1_release	= mouse_check_button_released(mb_left);
input_mouse2_click		= mouse_check_button_pressed(mb_right);
input_mouse2_hold		= mouse_check_button(mb_right);
input_mouse2_release	= mouse_check_button_released(mb_right);
input_mouse4_click		= mouse_check_button_pressed(mb_side1);
input_mouse5_click		= mouse_check_button_pressed(mb_side2);

// Input Space Bar Controls
input_space_press		= keyboard_check_pressed(vk_space);
input_space_hold		= keyboard_check(vk_space);
input_space_release		= keyboard_check_released(vk_space);

// Input Miscellaneous Controls
input_shift_press		= keyboard_check_pressed(vk_shift);
input_shift_hold		= keyboard_check(vk_shift);
input_control_press		= keyboard_check_pressed(vk_control);
input_control_hold		= keyboard_check(vk_control);

input_build_mode		= keyboard_check_pressed(ord("B"));