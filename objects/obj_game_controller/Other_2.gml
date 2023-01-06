///@desc	init game and inv system

////randomize seed
//randomize();

//init inventory system and load database
ex_init();
ex_db_load("database/resources.csv");
//ex_db_load("ex/armors.csv", "ex/foods.csv", "ex/potions.csv", "ex/weapons.csv");

////initialize the crafting system
//ex_craft_init();



// DEBUG MENU /////////////////////////////////////////////////////////////////
// DO NOT SAVE THE CONTENTS OF A CSV FILE WHILE GAME MAKER IS OPEN
file_grid = load_csv("database/resources.csv");
show_file_contents = false;
scroll_y = 96;