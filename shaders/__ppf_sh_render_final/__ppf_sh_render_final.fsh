
/*------------------------------------------------------------------
You cannot redistribute this pixel shader source code anywhere.
Only compiled binary executables. Don't remove this notice, please.
Copyright (C) 2022 Mozart Junior (FoxyOfJungle). Kazan Games Ltd.
Website: https://foxyofjungle.itch.io/ | Discord: FoxyOfJungle#0167
-------------------------------------------------------------------*/

varying vec2 v_vPosition;
varying vec2 v_vTexcoord;

uniform vec4 pos_res;
uniform vec2 time_n_intensity;
uniform float enabled[13];

// >> uniforms
uniform float dither_threshold;
uniform float dither_strength;
uniform float dither_mode;
uniform bool dither_coord_absolute;
uniform float dither_bayer_size;
uniform sampler2D dither_bayer_tex;

uniform float noise_grain_intensity;
uniform float noise_grain_scale;
uniform float noise_grain_mix;
uniform sampler2D noise_grain_tex;

uniform float mist_intensity;
uniform float mist_scale;
uniform float mist_tiling;
uniform float mist_speed;
uniform float mist_angle;
uniform float mist_contrast;
uniform float mist_power;
uniform float mist_remap;
uniform vec3 mist_color;
uniform float mist_mix;
uniform float mist_mix_threshold;
uniform sampler2D mist_noise_tex;

uniform float speed_lines_scale;
uniform float speed_lines_tiling;
uniform float speed_lines_speed;
uniform float speed_lines_rot_speed;
uniform float speed_lines_contrast;
uniform float speed_lines_power;
uniform float speed_lines_remap;
uniform vec3 speed_lines_color;
uniform float speed_lines_mask_power;
uniform float speed_lines_mask_scale;
uniform float speed_lines_mask_smoothness;
uniform sampler2D speed_lines_noise_tex;

uniform float vignette_intensity;
uniform float vignette_curvature;
uniform float vignette_inner;
uniform float vignette_outer;
uniform vec3 vignette_color;
uniform vec2 vignette_center;
uniform float vignette_rounded;
uniform float vignette_linear;

uniform float scanlines_intensity;
uniform float scanlines_speed;
uniform float scanlines_amount;
uniform vec3 scanlines_color;
uniform float scanlines_mask_power;
uniform float scanlines_mask_scale;
uniform float scanlines_mask_smoothness;

uniform float nes_fade_amount;
uniform float nes_fade_levels;

uniform float fade_amount;
uniform vec3 fade_color;

uniform float cinema_bars_amount;
uniform vec3 cinema_bars_color;
uniform float cinema_bars_vertical_enable;
uniform float cinema_bars_horizontal_enable;
uniform float cinema_bars_is_fixed;

uniform float color_blindness_mode;

uniform vec3 channel_rgb;


// >> dependencies
const float Tau = 6.2831;
const vec3 lum_weights = vec3(0.299, 0.587, 0.114);

uniform float lens_distortion_amount;
vec2 lens_distortion_uv(vec2 uv) {
	vec2 _uv = uv;
	vec2 uv2 = _uv - 0.5;
	float at = atan(uv2.x, uv2.y);
	float uvd = length(uv2);
	float dist = lens_distortion_amount * time_n_intensity.y;
	uvd *= (pow(uvd, 2.0) * dist + 1.0);
	_uv = vec2(0.5) + vec2(sin(at), cos(at)) * uvd;
	return _uv;
}

uniform float border_curvature;
uniform float border_smooth;
uniform vec3 border_color;
vec3 border_fx(vec3 color, vec2 uv) {
	vec3 _col = color;
	float curvature = border_curvature;
	if (curvature <= 0.005) curvature = 0.005;
	vec2 corner = pow(abs(uv*2.0-1.0), vec2(1.0/curvature));
	float edge = pow(length(corner), curvature);
	float border = smoothstep(1.0-border_smooth, 1.0, edge);
	return mix(_col, border_color, border);
}

float dither(vec2 pos) {  
	return texture2D(dither_bayer_tex, mod(pos, dither_bayer_size)/dither_bayer_size).r;
}

float rand(vec2 p, sampler2D tex) {
	return texture2D(tex, p).r;
}

// (C) 2016, Ashima Arts
/*vec3 mod2D289(vec3 x) {return x - floor( x * (1.0 / 289.0)) * 289.0;}
vec2 mod2D289(vec2 x) {return x - floor( x * (1.0 / 289.0)) * 289.0;}
vec3 permute(vec3 x) {return mod2D289(((x * 34.0) + 1.0) * x);}
float snoise(vec2 v) {
	const highp vec4 C = vec4(0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439);
	vec2 i = floor(v + dot(v, C.yy));
	vec2 x0 = v - i + dot(i, C.xx);
	vec2 i1;
	i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
	vec4 x12 = x0.xyxy + C.xxzz;
	x12.xy -= i1;
	i = mod2D289(i);
	vec3 p = permute(permute(i.y + vec3( 0.0, i1.y, 1.0 )) + i.x + vec3(0.0, i1.x, 1.0));
	vec3 m = max(0.5 - vec3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0.0);
	m = m * m;
	m = m * m;
	vec3 x = 2.0 * fract(p * C.www) - 1.0;
	vec3 h = abs(x) - 0.5;
	vec3 ox = floor(x + 0.5);
	vec3 a0 = x - ox;
	m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);
	vec3 g;
	g.x = a0.x * x0.x + h.x * x0.y;
	g.yz = a0.yz * x12.xz + h.yz * x12.yw;
	return 130.0 * dot(m, g);
}*/

vec2 get_aspect_ratio(vec2 res, vec2 size) {
	float aspect_ratio = res.x / res.y;
	return (res.x > res.y)
	? vec2(size.x * aspect_ratio, size.y)
	: vec2(size.x, size.y / aspect_ratio);
}

vec2 tiling(vec2 uv, vec2 tiling) {
	uv = (uv - 0.5) * tiling + 0.5;
	return mod(uv, 1.0);
}

vec2 tiling_mirror(vec2 uv, vec2 tiling) {
	uv = (uv - 0.5) * tiling + 0.5;
	uv = abs(mod(uv - 1.0, 2.0) - 1.0);
	return uv;
}

float saturate(float x) {
	return clamp(x, 0.0, 1.0);
}

vec3 saturate3(vec3 x) {
    return clamp(x, 0.0, 1.0);
}

vec3 blend(vec3 source, vec3 dest) {
	return source + dest - source * dest;
}

float mask_radial(vec2 uv, vec2 center, float power, float scale, float smoothness) {
	float smoothh = mix(scale, 0.0, smoothness);
	float sc = scale / 2.0;
	float mask = pow(1.0-saturate((length(uv-center)-sc) / ((smoothh-0.001)-sc)), power);
	return mask;
}

vec3 hsv2rgb(in vec3 color) {
	vec3 rgb = clamp(abs(mod(color.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
	return color.z * mix(vec3(1.0), rgb, color.y);
}


// >> effects
vec3 dithering_fx(vec3 color, vec2 fpos) {
	vec3 _col = color;
	vec2 vpos = (dither_coord_absolute) ? gl_FragCoord.xy : fpos;
	float lum = dot(_col, lum_weights);
	if (dither_mode == 0.0) {
		float br = lum - dither_threshold;
		float dit = br > dither(vpos) ? 1.0 : 0.0;
		_col = mix(_col, color * vec3(dit) + color, dither_strength);
	} else
	if (dither_mode == 1.0) {
		float br = lum - dither_threshold;
		_col = mix(_col, _col * 1.5 * floor(br + dither(vpos)), dither_strength);
	} else
	if (dither_mode == 2.0) {
		vec3 br = _col - dither_threshold;
		_col = mix(_col, _col * 1.5 * floor(br + dither(vpos)), dither_strength);
	}
	return _col;
}

vec3 noise_grain_fx(vec3 color, vec2 fpos) {
	vec3 _col = color;
	highp float time = time_n_intensity.x;
	highp vec2 uv1 = fpos / vec2(256.0, 256.0); // noise tex size
	highp vec2 uv2 = uv1;
	float noise;
	uv1.x += cos(time*135.0 + sin(time));
	uv1.y += sin(time*90.0 + cos(time));
	noise += rand(tiling_mirror(uv1, vec2(noise_grain_scale)), noise_grain_tex);
	uv2.x -= cos(time*135.0 + sin(time));
	uv2.y -= sin(time*90.0 + cos(time));
	noise += rand(tiling(uv2, vec2(noise_grain_scale)), noise_grain_tex);
	noise /= 2.0;
	vec3 grain = vec3(noise) * noise_grain_intensity;
	if (noise_grain_mix > 0.5) {
		_col = blend(_col, grain);
	} else {
		_col = grain;
	}
	return _col;
}

vec3 mist_fx(vec3 color, vec2 uv) {
	vec3 _col = color;
	highp float time = time_n_intensity.x * mist_speed*0.1;
	vec2 uv2 = uv;
	float angle = radians(mist_angle);
	mat2 rot = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
	uv2 = rot * (uv2 - 0.5) + 0.5;
	uv2 = tiling(uv2, vec2(mist_tiling*mist_scale, mist_tiling));
	uv2.x -= time;
	float perlin_noise = texture2D(mist_noise_tex, uv2).r * mist_contrast + 0.5;
	float fogg = saturate(pow(perlin_noise, mist_power) - mist_remap) / (1.0-mist_remap);
	float intensity = mist_intensity * time_n_intensity.y;
	vec3 limiar = max((color + clamp(mist_mix_threshold, -0.5, 0.5)) * intensity, 0.0);
	vec3 mist = vec3((fogg * mix(vec3(1.0), limiar, mist_mix)) * mist_color * intensity);
	_col = blend(_col, mist);
	return _col;
}

vec3 speedlines_fx(vec3 color, vec2 uv) {
	vec3 _col = color;
	vec2 center = uv - 0.5;
	highp float time = time_n_intensity.x * speed_lines_speed*0.1;
	vec2 uv2 = vec2((length(center) * speed_lines_scale * 0.5) - time, atan(center.y, center.x) * (1.0/Tau) * speed_lines_tiling);
	float angle = radians(time * speed_lines_rot_speed);
	uv2 *= mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
	float perlin_noise = texture2D(speed_lines_noise_tex, uv2).r * speed_lines_contrast + 0.5;
	float fast_lines = saturate(pow(perlin_noise, speed_lines_power) - speed_lines_remap) / (1.0-speed_lines_remap);
	float mask = mask_radial(uv, vec2(0.5), speed_lines_mask_power, speed_lines_mask_scale, speed_lines_mask_smoothness);
	_col = mix(_col, speed_lines_color, fast_lines * mask * time_n_intensity.y);
	return _col;
}

vec3 vignette_fx(vec3 color, vec2 uv) {
	vec3 _col = color;
	float curvature = vignette_curvature;
	curvature = clamp(curvature, 0.02, 1.0);
	vec2 dist = abs(uv - vignette_center) * 2.0;
	if (vignette_rounded > 0.5) dist = get_aspect_ratio(pos_res.zw, dist);
	vec2 curve = pow(dist, vec2(1.0/curvature));
    float edge = pow(length(curve), curvature);
	float vig = (vignette_linear > 0.5) ?
	smoothstep(vignette_inner, vignette_outer, edge) : pow(edge/vignette_outer, 1.0/vignette_inner);
	_col = mix(_col, vignette_color, saturate(vig) * vignette_intensity);
	return _col;
}

vec3 nes_fade_fx(vec3 color) {
	vec3 _col = color;
	// with help of Jan Vorisek
	_col = max(vec3(0.0), _col - nes_fade_amount);
	vec3 bias = vec3(1.0) / nes_fade_levels;
	_col = (floor((_col + bias) * nes_fade_levels) / nes_fade_levels) - bias;
	return _col;
}

vec3 scanlines_fx(vec3 color, vec2 uv) {
	vec3 _col = color;
	highp float time = time_n_intensity.x * scanlines_speed * 10.0;
	float lines = sin(time - (uv.y * 2.0*pos_res.w * scanlines_amount)) + 1.0;
	float mask = mask_radial(uv, vec2(0.5), scanlines_mask_power, scanlines_mask_scale, scanlines_mask_smoothness);
    _col = mix(_col, scanlines_color, lines * mask * scanlines_intensity);
	return _col;
}

vec3 fade_color_fx(vec3 color) {
	vec3 _col = color;
	_col = mix(_col, fade_color, fade_amount);
	return _col;
}

vec3 cinema_bars_fx(vec3 color, vec2 uv, vec2 uvl) {
	vec3 _col = color;
	vec2 _uv = (cinema_bars_is_fixed > 0.5) ? uv : uvl;
	vec2 uv2 = abs(_uv * 2.0 - 1.0);
	vec2 bars = 1.0-step(cinema_bars_amount, 1.0-uv2);
	if (cinema_bars_vertical_enable > 0.5) _col = mix(_col, cinema_bars_color, bars.y);
	if (cinema_bars_horizontal_enable > 0.5) _col = mix(_col, cinema_bars_color, bars.x);
	return _col;
}

vec3 color_blindness_fx(vec3 color) {
	//http://blog.noblemaster.com/2013/10/26/opengl-shader-to-correct-and-simulate-color-blindness-experimental/
	vec3 _col = color;
	if (color_blindness_mode == 0.0) { // protanopia
		_col *= mat3(0.20, 0.99, -0.19,
					0.16, 0.79, 0.04,
					0.01, -0.01, 1.00);
	} else
	if (color_blindness_mode == 1.0) { // deuteranopia
		_col *= mat3(0.43, 0.72, -0.15,
					0.34, 0.57, 0.09,
					-0.02, 0.03, 1.00);
	} else
	if (color_blindness_mode == 2.0) { // tritanopia
		_col *= mat3(0.97, 0.11, -0.08,
					0.02, 0.82, 0.16,
					-0.06, 0.88, 0.18);
	}
	return _col;
}

vec3 channels_fx(vec3 color) {
	vec3 _col = color;
	_col.rgb *= channel_rgb.xyz;
	return _col;
}

void main() {
	vec2 vPos = (v_vPosition - pos_res.xy);
	vec2 uv = v_vTexcoord;
	
	// [d] lens distortion
	vec2 uvl = uv;
	if (enabled[0] > 0.5) uvl = lens_distortion_uv(uv);
	
	// image
	vec4 col_tex = texture2D(gm_BaseTexture, uv);
	vec3 col_final = col_tex.rgb;
	
	// mist_fx
	if (enabled[1] > 0.5) col_final = mist_fx(col_final, uvl);
	
	// speedlines_fx
	if (enabled[2] > 0.5) col_final = speedlines_fx(col_final, uvl);
	
	// dithering_fx
	if (enabled[3] > 0.5) col_final = dithering_fx(col_final, vPos);
	
	// noise_grain_fx
	if (enabled[4] > 0.5) col_final = noise_grain_fx(col_final, vPos);
	
	// vignette_fx
	if (enabled[5] > 0.5) col_final = vignette_fx(col_final, uvl);
	
	// nes_fade_fx
	if (enabled[6] > 0.5) col_final = nes_fade_fx(col_final);
	
	// scanlines_fx
	if (enabled[7] > 0.5) col_final = scanlines_fx(col_final, uvl);
	
	// fade_color_fx
	if (enabled[8] > 0.5) col_final = fade_color_fx(col_final);
	
	// cinema bars
	if (enabled[9] > 0.5) col_final = cinema_bars_fx(col_final, uv, uvl);
	
	// color_blindness_fx
	if (enabled[10] > 0.5) col_final = color_blindness_fx(col_final);
	
	// channels_fx
	if (enabled[11] > 0.5) col_final = channels_fx(col_final);
	
	// [d] border_fx
	if (enabled[12] > 0.5) col_final = border_fx(col_final, uvl);
	
	gl_FragColor = mix(col_tex, vec4(mix(col_tex.rgb, col_final, time_n_intensity.y), 1.0), col_tex.a);
}
