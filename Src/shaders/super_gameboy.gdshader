shader_type canvas_item;
/*
inspired by the Super GameBoy, this shader will mimic the functionality
of the Nintendo addon by downsampling the color palette of an image to any of
a range of premade palettes. Best used with B&W images
* palettes sourced from: https://www.deviantart.com/advancedfan2020/art/Game-Boy-Palette-Set-Super-Pocket-Boy-1008908495
*/

//uniforms
//thresholds
uniform float threshold_a : hint_range(0.0, 1.0) = 0.25;
uniform float threshold_b : hint_range(0.0, 1.0) = 0.50;
uniform float threshold_c : hint_range(0.0, 1.0) = 0.75;

//palettes
//uniforms of palettes
/*
uniform vec3[4] palette_bw : source_color;
uniform vec3[4] palette_green : source_color;
uniform vec3[4] palette_purple_haze : source_color;
uniform vec3[4] palette_purple_pride : source_color;
uniform vec3[4] palette_marvelous_pink : source_color;
uniform vec3[4] palette_silly_putty : source_color;
uniform vec3[4] palette_real_rasberry : source_color;
uniform vec3[4] palette_dizzy_days : source_color;
uniform vec3[4] palette_troll_slayer_orange : source_color;
uniform vec3[4] palette_goldfinch_yellow : source_color;
uniform vec3[4] palette_lepton_gold : source_color;
uniform vec3[4] palette_slick_mud : source_color;*/

//consant equivilent of palettes
const vec3[4] black_white = {vec3(0.0), vec3(0.25), vec3(0.75), vec3(1.0)};
const vec3[4] green = {vec3(0, 0.09, 0),vec3(0, 0.6, 0), vec3(0, 0.83, 0), vec3(0, 1.0, 0)};
const vec3[4] purple_haze = {vec3(0.05, 0.04, 0.05), vec3(0.2, 0.17, 0.24), vec3(0.35, 0.30, 0.42), vec3(0.5, 0.44, 0.60)};
const vec3[4] purple_pride = {vec3(0.06, 0.04, 0.07), vec3(0.26, 0.18, 0.28), vec3(0.45, 0.32, 0.5), vec3(0.65, 0.46, 0.71)};
const vec3[4] marvelous_pink = {vec3(0.08, 0.07, 0.07), vec3(0.33, 0.27, 0.3), vec3(0.59, 0.48, 0.52), vec3(0.84, 0.69, 0.75)};
const vec3[4] silly_putty = {vec3(0.09, 0.06, 0.07), vec3(0.37, 0.27, 0.29), vec3(0.65, 0.48, 0.52), vec3(0.93, 0.91, 0.98)};
const vec3[4] real_rasberry = {vec3(0.08, 0.04, 0.06), vec3(0.34, 0.18, 0.26), vec3(0.61, 0.32, 0.45), vec3(0.87, 0.46, 0.65)};
const vec3[4] dizzy_days = {vec3(0.08, 0.03, 0.01), vec3(0.32, 0.12, 0.07), vec3(0.56, 0.21, 0.12), vec3(0.81, 0.30, 0.18)};
const vec3[4] troll_slayer_orange = {vec3(0.09, 0.06, 0.03), vec3(0.38, 0.25, 0.12), vec3(0.67, 0.43, 0.21), vec3(0.96, 0.62, 0.3)};
const vec3[4] goldfinch_yellow = {vec3(0.09, 0.08, 0.04), vec3(0.38, 0.34, 0.17), vec3(0.67, 0.61, 0.3), vec3(0.96, 0.87, 0.43)};
const vec3[4] lepton_gold = {vec3(0.08, 0.06, 0.0), vec3(0.32, 0.25, 0.0), vec3(0.56, 0.43, 0.0), vec3(0.81, 0.62, 0.0)};
const vec3[4] slick_mud = {vec3(0.06, 0.04, 0.02), vec3(0.26, 0.17, 0.1), vec3(0.45, 0.3, 0.19), vec3(0.65, 0.43, 0.27)};

//selected palette
uniform int selected_palette : hint_range(0,11) = 0;

//return palette depending on value of selected_palette
vec3[4] get_palette(){
		switch (selected_palette){
		case 0:
			return black_white;
		case 1:
			return green;
		case 2:
			return purple_haze;
		case 3:
			return purple_pride;
		case 4:
			return marvelous_pink;
		case 5:
			return silly_putty;
		case 6:
			return real_rasberry;
		case 7:
			return dizzy_days;
		case 8:
			return troll_slayer_orange;
		case 9:
			return goldfinch_yellow;
		case 10:
			return lepton_gold;
		case 11:
			return slick_mud;
	}
}

void fragment() {
	//sample colors from image
	vec4 colors = texture(TEXTURE, UV);
	
	//set palette that image will change to
	vec3[4] palette = get_palette();

	//set image value to palette value depending on 
	vec3 final_color;
	if (distance(colors.rgb, vec3(threshold_a)) <= threshold_a) {
		final_color = palette[0];
	} else if (distance(colors.rgb, vec3(threshold_b)) <= threshold_b){
		final_color = palette[1];
	} else if (distance(colors.rgb, vec3(threshold_c)) <= threshold_c){
		final_color = palette[2];
	} else {
		final_color = palette[3];
	}
	
	//call set palette function
	colors.rgb = final_color;
	COLOR = colors;
}
