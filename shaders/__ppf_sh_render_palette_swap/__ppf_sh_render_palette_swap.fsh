
/*------------------------------------------------------------------
You cannot redistribute this pixel shader source code anywhere.
Only compiled binary executables. Don't remove this notice, please.
Copyright (C) 2022 Mozart Junior (FoxyOfJungle). Kazan Games Ltd.
Website: https://foxyofjungle.itch.io/ | Discord: FoxyOfJungle#0167
-------------------------------------------------------------------*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// >> uniforms
uniform vec2 time_n_intensity;
uniform float palette_swap_row;
uniform float palette_swap_height;
uniform float palette_swap_threshold;
uniform bool palette_swap_flip;
uniform sampler2D palette_swap_tex;

// >> dependencies
const vec3 lum_weights = vec3(0.299, 0.587, 0.114);

// >> effect
vec3 palette_swap_fx(vec3 color) {
	vec3 _col = color;
	float lum = dot(_col, lum_weights);
	
	vec2 uv2 = vec2(palette_swap_flip ? 1.0-lum : lum, 1.0-ceil(1.0+palette_swap_row)/palette_swap_height);
	vec3 col_pal = texture2D(palette_swap_tex, uv2).rgb;
	
	if (length(_col - col_pal.rgb) >= palette_swap_threshold) {
		_col = col_pal;
	}
	return _col;
}

void main() {
	vec2 uv = v_vTexcoord;
	vec4 col_tex = texture2D(gm_BaseTexture, uv);
	vec3 col_final = col_tex.rgb;
	col_final = palette_swap_fx(col_final);
	gl_FragColor = mix(col_tex, vec4(mix(col_tex.rgb, col_final, time_n_intensity.y), 1.0), col_tex.a);
}
