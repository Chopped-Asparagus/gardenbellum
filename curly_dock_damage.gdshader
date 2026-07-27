shader_type canvas_item;

instance uniform bool red = false;

void fragment() {
	if (red == true) {
		COLOR.r += 0.4;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
