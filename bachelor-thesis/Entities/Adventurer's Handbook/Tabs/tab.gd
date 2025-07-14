@tool
extends Control

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var label:Label = $Label

signal pressed()

@export var texture:Texture2D = null:
	set(new):
		if texture == new:
			return
		if is_instance_valid(texture):
			texture.changed.disconnect(queue_redraw)
		texture = new
		if is_instance_valid(texture):
			texture.changed.connect(queue_redraw)
		queue_redraw()
@export var frames:int = 1:
	set(new):
		frames = maxi(new, 1)
		frame = frame
		queue_redraw()
@export var frame:int:
	set(new):
		frame = clampi(new, 0, frames - 1)
		queue_redraw()
@export var text:String:
	set(new):
		text = new
		if is_node_ready():
			label.text = text

func _ready() -> void:
	label.text = text
	focus_entered.connect(queue_redraw)
	focus_exited.connect(queue_redraw)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and not event.is_echo():
			pressed.emit()

func open():
	animation_player.play(&"open")

func close():
	animation_player.play(&"close")
	await animation_player.animation_finished

func _draw() -> void:
	if not is_instance_valid(texture):
		return
	var calc_width:float = texture.get_width() / frames
	draw_texture_rect_region(
		texture, 
		Rect2(0, 0, calc_width, texture.get_height()),
		Rect2(calc_width * frame, 0, calc_width, texture.get_height()),
	)
	custom_minimum_size = Vector2(calc_width, texture.get_height())
	if not has_focus():
		return
	#var focus:StyleBox = get_theme_stylebox(&"focus", &"Button")
	#if not focus:
	#	return
	#focus.draw(get_canvas_item(), Rect2(Vector2.ZERO, size))
