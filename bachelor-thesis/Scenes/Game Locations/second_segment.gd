extends Node2D

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Global.area2_entered == false:
		Dialogic.start("res://Dialogue/Timelines/Used/Seg_2.dtl")
		Global.area2_entered = true
	#Check global variable to set state of the room
	if Global.minecart_solved == true:
		$Closed.hide()
		$Open.show()

func _on_dialogic_signal(argument : String):
	if argument == "open_chest":
		$Mimic/Closed.hide()
		$Mimic/Open.show()
