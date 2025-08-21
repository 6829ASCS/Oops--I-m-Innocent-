shader_type canvas_item;
render_mode unshaded, skip_vertex_transform;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;
uniform float amplitude : hint_range(0.0, 50.0) = 10.0; // wobble strength
uniform float frequency : hint_range(0.0, 20.0) = 10.0; // how wavy
uniform float speed : hint_range(0.0, 5.0) = 1.0; // how fast it moves

void fragment() {
    // Center coordinates from -1 to 1
    vec2 centered_uv = SCREEN_UV * 2.0 - 1.0;

    // Wavy offsets
    float offset_x = sin(centered_uv.y * frequency + TIME * speed) * amplitude / 100.0;
    float offset_y = cos(centered_uv.x * frequency + TIME * speed) * amplitude / 100.0;

    vec2 warped_uv = SCREEN_UV + vec2(offset_x, offset_y);

    // Sample the screen
    vec3 color = textureLod(screen_texture, warped_uv, 0.0).rgb;

    COLOR = vec4(color, 1.0);
}
