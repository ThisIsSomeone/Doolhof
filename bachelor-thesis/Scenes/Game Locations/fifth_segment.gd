extends Node2D

@onready var liar : Node2D = $Liar
@onready var truther : Node2D = $Truther

@onready var nextareas = $NextAreas

#Starts Segment 5 upon Loading in World
func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("res://Dialogue/Timelines/Used/Seg_5.dtl")

func _on_dialogic_signal(argument :String):
	if argument == "move_guards":
		var left : Tween = create_tween()
		left.tween_property(liar, "position:x", liar.position.x + 35, 1.5)
		var right : Tween = create_tween()
		right.tween_property(truther, "position:x", truther.position.x - 35, 1.5)
		right.tween_callback(nextareas.show)
	if argument == "set_correct":
		#Set Left Path to Correct
		$NextAreas/Treasure.path = "res://Scenes/Game Locations/Conclusion_Treasure.tscn"

#Talking to the liar
func _on_liar_trigger_trigger_dialogue():
	Dialogic.VAR.set_variable("Segment 5.Guards", false)

#Talking to the truther
func _on_truther_trigger_trigger_dialogue():
	Dialogic.VAR.set_variable("Segment 5.Guards", true)
