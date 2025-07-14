extends "res://Entities/NPC/npc.gd"

@export var min_score : int = 50
@export var timer_duration : int = 120
@export var penalty : int = 50
@export_file("*.dtl") var path : String

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_click():
	super()
	#Start Dialogue
	Dialogic.start(ResourceUID.get_id_path(ResourceUID.text_to_id(path))) #Convert UID into String

func _on_dialogic_signal(argument: String):
	if argument == "clear":
		Global.update_first_try()
		#Update Score
		if $Timer.time_left > 50:
			Global.modify_score($Timer.time_left)
		else:
			Global.modify_score(min_score)
		$Timer.stop()
	if argument == "pause":
		$Timer.paused = true
	if argument == "start":
		if $Timer.is_stopped():
			$Timer.start(timer_duration)
		else:
			$Timer.paused = false
		pass
	if argument == "incorrect":
		Global.update_incorrect()
		if $Timer.time_left > penalty:
			var temp = $Timer.time_left
			$Timer.stop()
			$Timer.start(temp - penalty)
