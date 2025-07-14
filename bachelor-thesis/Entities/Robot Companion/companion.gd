extends Control

#Keeps track of which timeline the robot has
var index : int = -1

#Collection of Timelines for the robot
var timelines : Dictionary[int, String] = {
	-1: "res://Dialogue/Timelines/Used/Robot Assistance/Tutorial/IdleTutorial.dtl", #Default State, Stub Timeline
	0: "res://Dialogue/Timelines/Used/Robot Assistance/Tutorial/IdleTutorial.dtl", #Default State Tutorial Zone
	1: "res://Dialogue/Timelines/Used/Robot Assistance/Tutorial Assistance.dtl", #Tutorial Assistance
	2: "res://Dialogue/Timelines/Used/Robot Assistance/Tutorial/False.dtl", #Fout
	3: "res://Dialogue/Timelines/Used/Robot Assistance/Tutorial/LetsGo.dtl", #Let's Go Tutorial
	4: "res://Dialogue/Timelines/Used/Robot Assistance/Segment 1 Assistance.dtl", #Segment 1 Robot Companion
	5: "res://Dialogue/Timelines/Used/Robot Assistance/Segment 2 Assistance.dtl", #Segment 2 Robot Companion
	10: "res://Dialogue/Timelines/Used/Robot Assistance/Segment 5 Assistance.dtl" #Segment 5 Robot Companion
}

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_texture_button_pressed():
	#TODO: Check computational intensity on low laptops
	#TODO: Make sure it doesn't clear the state if a timeline is NOT playing, cause then it'd be redundant
	Dialogic.clear(DialogicGameHandler.ClearFlags.KEEP_VARIABLES)
	Global.update_RC_tracker()
	Dialogic.start(timelines[index]) #Play Robot Timeline

func _on_dialogic_signal(argument: String):
	if argument == "disable_RC":
		_set_inactive()
	if argument == "enable_RC":
		_set_active_()
	if argument == "set_RC":
		#Sets new timeline
		index = Dialogic.VAR.Companion

func _set_inactive():
	$RC.disabled = true

func _set_active_():
	$RC.disabled = false
