shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float scale_y;

void fragment() {
	float uv_height = SCREEN_PIXEL_SIZE.y / TEXTURE_PIXEL_SIZE.y;
	vec2 reflection_of_our_world = vec2(SCREEN_UV.x, SCREEN_UV.y + uv_height * UV.y *scale_y);
 	vec4 reflection = textureLod(SCREEN_TEXTURE, reflection_of_our_world, 0.0);
	COLOR = reflection;
}
