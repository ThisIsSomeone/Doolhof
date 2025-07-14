shader_type canvas_item;

uniform float line_smoothness : hint_range(0, 0.1) = 0.045;
uniform float Line_Width : hint_range(0, 0.2) = 0.09;
uniform float brightness = 3.0;
uniform float rotation_deg : hint_range(-90, 90) = 30;
uniform float distortion : hint_range(1, 2) = 1.8;
uniform float speed = 0.7;
uniform float position : hint_range(0, 1) = 0;
uniform float position_min = 0.25;
uniform float position_max = 0.5;
uniform float alpha : hint_range(0, 1) = 1;
uniform vec3 line_color : source_color;

vec2 rotate_uv(vec2 uv, vec2 center, float rotation, bool use_degrees){
		float _angle = rotation;
		if(use_degrees){
			_angle = rotation * (3.1415926/180.0);
		}
		mat2 _rotation = mat2(
			vec2(cos(_angle), -sin(_angle)),
			vec2(sin(_angle), cos(_angle))
		);
		vec2 _delta = uv - center;
		_delta = _rotation * _delta;
		return _delta + center;
	}

void fragment() {
	
	vec2 center_uv = UV - vec2(0.5, 0.5);
	float gradient_to_edge = max(abs(center_uv.x), abs(center_uv.y));
	gradient_to_edge = gradient_to_edge * distortion;
	gradient_to_edge = 1.0 - gradient_to_edge;
	vec2 rotaded_uv = rotate_uv(UV, vec2(0.5, 0.5), rotation_deg, true);
	
	float remapped_position;
	{
		float output_range = position_max - position_min;
		remapped_position = position_min + output_range * position;
	}
	
	float remapped_time = TIME * speed + remapped_position;
	remapped_time = fract(remapped_time);
	{
		float output_range = 2.0 - (-2.0);
		remapped_time = -2.0 + output_range * remapped_time;
	}
	
	vec2 offset_uv = vec2(rotaded_uv.xy) + vec2(remapped_time, 0.0);
	float line = vec3(offset_uv, 0.0).x;
	line = abs(line);
	line = gradient_to_edge * line;
	line = sqrt(line);
	
	float line_smoothness_th = clamp(line_smoothness, 0.001, 1.0);
	float offset_plus = Line_Width + line_smoothness_th;
	float offset_minus = Line_Width - line_smoothness_th;
	
	float remapped_line;
	{
		float input_range = offset_minus - offset_plus;
		remapped_line = (line - offset_plus) / input_range;
	}
	remapped_line = remapped_line * brightness;
	remapped_line = min(remapped_line, alpha);
	remapped_line = clamp(remapped_line, 0.0, 1.0);
	COLOR.rgb = mix(COLOR.rgb, line_color, remapped_line);
}

//Made by https://godotshaders.com/author/andich-xyz/
//Edited by UwUMacaronitime