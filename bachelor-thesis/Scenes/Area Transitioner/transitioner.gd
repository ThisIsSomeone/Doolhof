extends Area2D

@export_file("*.tscn") var path : String

#When clicked, call wipe_to_scene with our desired scene
func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.is_released():
			#Reset mouse cursor
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			#Load desired scene
			get_tree().get_first_node_in_group("World").wipe_to_scene(load(path))


#Sets mouse icon
func _on_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
