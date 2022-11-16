// Initialize input variables
var input_restart, input_quit;

input_restart   = keyboard_check_pressed(ord("R"));
input_quit      = keyboard_check_pressed(vk_escape);

// Restart application
if (input_restart)
    game_restart();
    
// Close application
if (input_quit)
    game_end();