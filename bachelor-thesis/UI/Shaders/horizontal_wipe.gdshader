shader_type canvas_item;

uniform float progress;

void fragment() {
	//UV is a vector, where 0,0 represents top-left of image, 1,1 is bottom right.
	//Based on progress, makes a certain part of the old scene transparent
	if(UV.x > 1.0 - progress){
		COLOR = vec4(0.0,0.0,0.0,0.0);
	}
	else {
		COLOR = texture(TEXTURE, UV);
	}
}
