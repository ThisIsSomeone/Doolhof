extends Node2D

var disabled : bool = false
@export var modus : int = 0
#mc_1, 2, 3 or 4
@export var minecart : String = "mc_1"
@export_file("*.dtl") var path : String

signal moved_minecarts

func _ready():
	$DialogueTrigger.path = path
	Dialogic.signal_event.connect(_on_dialogic_signal)
	move_minecart()

func move_minecart():
	if not disabled:
		disabled = true
		if modus == 0:
			var tween : Tween = create_tween()
			tween.tween_property(self, "position", Vector2(position.x,-40), 0.5)
			tween.tween_callback(enabler)
		if modus == 1:
			var tween : Tween = create_tween()
			tween.tween_property(self, "position", Vector2(position.x,-20), 0.5)
			tween.tween_callback(enabler)
		if modus == 2:
			var tween : Tween = create_tween()
			tween.tween_property(self, "position", Vector2(position.x,+0), 0.5)
			tween.tween_callback(enabler)
		if modus == 3:
			var tween : Tween = create_tween()
			tween.tween_property(self, "position", Vector2(position.x,+30), 0.5)
			tween.tween_callback(enabler)
		if modus == 4:
			var tween : Tween = create_tween()
			tween.tween_property(self, "position", Vector2(position.x,+50), 0.5)
			tween.tween_callback(enabler)

func enabler():
	disabled = false
	modus = (modus + 1) % 5
	#TODO: Add a check for if puzzle 2 has been completed, That way, even if a plalyer messes around and accidentally gets the right solution, it doesn't trigger the puzzle to be solved
	emit_signal("moved_minecarts")

func _on_dialogic_signal(argument: String):
	if argument == minecart:
		move_minecart()
