/// @description Insert description here
// You can write your code in this editor

var xDirection = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var jump = keyboard_check_pressed(vk_space);
var onTheGround = place_meeting(x, y + 1, oMoon);

xSpeed = xDirection * spd;
ySpeed += grav;

if (onTheGround && jump) 
{
	ySpeed = -7;
}

if (place_meeting(x + xSpeed, y, oMoon)) 
{ 
	while (!place_meeting(x + sign(xSpeed), y, oMoon)) 
	{
		x += sign(xSpeed);
	}
	xSpeed = 0; 
}
x += xSpeed;


if (place_meeting(x, y + ySpeed, oMoon)) 
{
	while (!place_meeting(x, y + sign(ySpeed), oMoon)) 
	{
		y += sign(ySpeed);
	}
	ySpeed = 0; 
}
y += ySpeed;
