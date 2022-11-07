
// scale
curve_progress = min(curve_progress+scale_spd, 1);
var _scale_progress = animcurve_channel_evaluate(curve_channel, curve_progress);
image_scale = _scale_progress * scale;

// alpha
alpha = max(alpha-alpha_spd, 0);
//alpha = lerp(alpha, 0, 0.1);
if (alpha == 0) instance_destroy();
