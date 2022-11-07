
/*------------------------------------------------------------------
You cannot redistribute this pixel shader source code anywhere.
Only compiled binary executables. Don't remove this notice, please.
Copyright (C) 2022 Mozart Junior (FoxyOfJungle). Kazan Games Ltd.
Website: https://foxyofjungle.itch.io/ | Discord: FoxyOfJungle#0167
-------------------------------------------------------------------*/

varying vec2 v_vTexcoord;

uniform float bokeh_radius;
uniform float focus_distance;
uniform float focus_range;
uniform float use_zdepth;
uniform sampler2D zdepth_tex;

// >> dependencies
uniform float lens_distortion_enable;
uniform float lens_distortion_amount;
vec2 lens_distortion_uv(vec2 uv) {
	vec2 _uv = uv;
	vec2 uv2 = _uv - 0.5;
	float at = atan(uv2.x, uv2.y);
	float uvd = length(uv2);
	float dist = lens_distortion_amount;
	uvd *= (pow(uvd, 2.0) * dist + 1.0);
	_uv = vec2(0.5) + vec2(sin(at), cos(at)) * uvd;
	return _uv;
}

float get_CoC(float depth, float f_distance, float f_range) {
	float coc = clamp((1.0 / f_distance - 1.0 / depth) * f_range, -1.0, 1.0);
	return abs(coc) * bokeh_radius;
}

void main() {
	if (use_zdepth > 0.5) {
		vec2 uv = v_vTexcoord;
		float depth = texture2D(zdepth_tex, lens_distortion_enable > 0.5 ? lens_distortion_uv(uv) : uv).r;
		float range = get_CoC(depth, focus_distance, focus_range);
		gl_FragColor = vec4(vec3(range), 1.0);
	} else {
		gl_FragColor = vec4(1.0);
	}
}
