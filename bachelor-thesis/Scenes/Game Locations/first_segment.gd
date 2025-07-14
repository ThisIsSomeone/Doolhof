extends Node2D

#Starts Segment 1 Upon Loading in World
func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("res://Dialogue/Timelines/Used/Seg_1.dtl")

func _on_dialogic_signal(argument :String):
	if argument == "open_gate_seg1":
		$Closed.hide()
		$Open.show()
