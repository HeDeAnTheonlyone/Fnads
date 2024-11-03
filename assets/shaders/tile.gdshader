shader_type canvas_item;

uniform sampler2D tileTex : repeat_enable;
uniform vec2 tileAmount;

void fragment() {
	vec2 tiledUV = UV * tileAmount;
	vec4 texColor = texture(tileTex, tiledUV);
	COLOR = texColor; 
}
