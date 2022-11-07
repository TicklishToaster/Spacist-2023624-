
/*---------------------------------------------------------------------------------
This object is nothing more than a sprite with normal map. Post-Processing FX will
distort the image according to the sprite. Be creative to do whatever you want with
this object. :)
---------------------------------------------------------------------------------*/

sprite = __spr_ppf_shockwave_normal;
//index = 0;
//scale = 3; // 0.5
angle = 0;
alpha = 1;

image_scale = 0;
//scale_spd = 0.02;
//alpha_spd = 0.03;

curve_channel = animcurve_get_channel(__ac_ppf_shockwave, 0);
curve_progress = 0;
