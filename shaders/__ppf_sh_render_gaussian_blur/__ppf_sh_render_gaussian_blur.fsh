
/*------------------------------------------------------------------
You cannot redistribute this pixel shader source code anywhere.
Only compiled binary executables. Don't remove this notice, please.
Copyright (C) 2022 Mozart Junior (FoxyOfJungle). Kazan Games Ltd.
Website: https://foxyofjungle.itch.io/ | Discord: FoxyOfJungle#0167
-------------------------------------------------------------------*/

varying vec2 v_vTexcoord;

// quality (low number = more performance)
#ifdef _YY_HLSL11_
#define ITERATIONS 32.0 // windows
#else
#define ITERATIONS 16.0 // others (android, operagx...)
#endif

const float directions = 16.0;
const float Tau = 6.28318530718;

const float ITERATIONS_RECIPROCAL = 1.0/ITERATIONS;
const float TAU_RECIPROCAL = Tau/directions;

// >> uniforms
uniform vec2 resolution;
uniform vec2 time_n_intensity;
uniform float gaussian_blur_amount;

// >> effect
vec4 gaussian_blur_fx(vec2 uv) {
	vec2 radius = (gaussian_blur_amount / (resolution*0.01)) * time_n_intensity.y;
	vec4 blur;
	for (float dir = 0.0; dir < Tau; dir += TAU_RECIPROCAL) {
		for (float i = ITERATIONS_RECIPROCAL; i <= 1.0; i += ITERATIONS_RECIPROCAL) {
			blur += texture2D(gm_BaseTexture, uv + vec2(cos(dir), sin(dir)) * i * radius, 0.5);		
		}
	}
	blur /= ITERATIONS * directions;
	return blur;
}

void main() {
	gl_FragColor = gaussian_blur_fx(v_vTexcoord);
}
