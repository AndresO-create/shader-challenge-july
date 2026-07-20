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
//selected palette
uniform int selected_palette : hint_range(0,11) = 0;

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
uniform vec3[4] palette_slick_mud : source_color;

//return palette depending on value of selected_palette
vec3[4] get_palette(){
		switch (selected_palette){
		case 0:
			return palette_bw;
		case 1:
			return palette_green;
		case 2:
			return palette_purple_haze;
		case 3:
			return palette_purple_pride;
		case 4:
			return palette_marvelous_pink;
		case 5:
			return palette_silly_putty;
		case 6:
			return palette_real_rasberry;
		case 7:
			return palette_dizzy_days;
		case 8:
			return palette_troll_slayer_orange;
		case 9:
			return palette_goldfinch_yellow;
		case 10:
			return palette_lepton_gold;
		case 11:
			return palette_slick_mud;
	}
}

void fragment() {
	//sample colors from image
	vec4 colors = texture(TEXTURE, UV);
	
	//set palette that image will change to
	vec3[4] palette = get_palette();

	//set image value to palette value depending on luminance
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
