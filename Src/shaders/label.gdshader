shader_type canvas_item;
/*Moves object up and down slowly depending on amplitude and frequency*/

uniform float amp : hint_range(0.0, 10.0, 1) = 1.0;
uniform float frequency : hint_range(0.0, 1.0, 0.1) = 1.0;

void vertex() {
	VERTEX.g += amp * sin(frequency * TIME);
}
