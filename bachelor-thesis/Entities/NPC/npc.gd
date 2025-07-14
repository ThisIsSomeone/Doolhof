extends Area2D

#When clicked
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and not event.is_released():
		if event.button_index == MOUSE_BUTTON_LEFT and not event.is_released():
			_on_click()

func _on_click():
	#Reset mouse cursor
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

#Sets mouse icon
func _on_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
