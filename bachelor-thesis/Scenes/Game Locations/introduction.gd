extends Node2D

#Starts Tutorial Upon Loading in World
func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("res://Dialogue/Timelines/Used/Game_Start.dtl")

func _on_dialogic_signal(argument :String):
	if argument == "open_gate_tutorial":
		$Gate.hide()
		$Transitioner.show()
