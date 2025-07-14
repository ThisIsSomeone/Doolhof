extends Node2D

#Starts Conclusion upon Loading in World
func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("res://Dialogue/Timelines/Used/Conclusion.dtl")
	Dialogic.VAR.set_variable("Conclusion.bad_ending", true)
	
func _on_dialogic_signal(argument :String):
	pass
