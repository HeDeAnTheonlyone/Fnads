shader_type canvas_item;

uniform float scrollX;
uniform float scrollY;

void fragment() {
	vec4 texColor = texture(TEXTURE, UV + vec2(scrollX, scrollY) * TIME);
    COLOR = texColor;
}