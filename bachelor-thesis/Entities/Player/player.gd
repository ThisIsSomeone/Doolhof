extends Camera2D

@onready var guidebookarrow : TextureRect = $UI/Mother/GuidebookArrow
@onready var robotarrow : TextureRect = $UI/Mother/RobotArrow
@onready var scorearrow : TextureRect = $UI/Mother/ScoreArrow

@onready var panel : Panel = $"UI/Mother/Score Tracker/Panel"
@onready var red : Panel = $"UI/Mother/Score Tracker/Panel/Red"
@onready var green : Panel = $"UI/Mother/Score Tracker/Panel/Green"

@onready var timing : Panel = $"UI/Mother/Puzzle Timer/Panel"
@onready var timered : Panel = $"UI/Mother/Puzzle Timer/Panel/Red"
@onready var timegreen : Panel = $"UI/Mother/Puzzle Timer/Panel/Green"

@onready var scoretext : RichTextLabel = $"UI/Mother/Score Tracker/Panel/RichTextLabel"
@onready var handbook : CanvasLayer = $"UI/Mother/UI/Adventurer's Handbook/Handbook"

func _ready() -> void:
	Global.update_score.connect(_update_score)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.History.simple_history_enabled = true
	
#Opens the Adventurer's Handbook
func _on_book_opener_pressed():
	#TODO: Send out a signal that might pause any possible puzzle_timers | Low priority, QoL
	handbook.open_book() #Enable Handbook
	Dialogic.paused = true

#Flash Score Box Red
func _correct():
	green.show()
	await get_tree().create_timer(0.2).timeout
	green.hide()
	await get_tree().create_timer(0.2).timeout
	green.show()
	await get_tree().create_timer(0.2).timeout
	green.hide()
	await get_tree().create_timer(0.2).timeout
	green.show()
	await get_tree().create_timer(0.2).timeout
	green.hide()

#Flash Score Box Green
func _incorrect():
	red.show()
	await get_tree().create_timer(0.2).timeout
	red.hide()
	await get_tree().create_timer(0.2).timeout
	red.show()
	await get_tree().create_timer(0.2).timeout
	red.hide()
	await get_tree().create_timer(0.2).timeout
	red.show()
	await get_tree().create_timer(0.2).timeout
	red.hide()

#Updates score when signal is called
func _update_score(score:String):
	scoretext.text = "[center]Score: " + score

func _on_dialogic_signal(argument: String):
	if argument == "point_guidebook":
		guidebookarrow.show()
		await get_tree().create_timer(0.2).timeout
		guidebookarrow.hide()
		await get_tree().create_timer(0.2).timeout
		guidebookarrow.show()
		await get_tree().create_timer(0.2).timeout
		guidebookarrow.hide()
		await get_tree().create_timer(0.2).timeout
		guidebookarrow.show()
		await get_tree().create_timer(0.2).timeout
		guidebookarrow.hide()
	if argument == "point_robot":
		robotarrow.show()
		await get_tree().create_timer(0.2).timeout
		robotarrow.hide()
		await get_tree().create_timer(0.2).timeout
		robotarrow.show()
		await get_tree().create_timer(0.2).timeout
		robotarrow.hide()
		await get_tree().create_timer(0.2).timeout
		robotarrow.show()
		await get_tree().create_timer(0.2).timeout
		robotarrow.hide()
	if argument == "point_score":
		scorearrow.show()
		await get_tree().create_timer(0.2).timeout
		scorearrow.hide()
		await get_tree().create_timer(0.2).timeout
		scorearrow.show()
		await get_tree().create_timer(0.2).timeout
		scorearrow.hide()
		await get_tree().create_timer(0.2).timeout
		scorearrow.show()
		await get_tree().create_timer(0.2).timeout
		scorearrow.hide()
	if argument == "end_game":
		#Go to the end of the game
		get_tree().change_scene_to_file("res://Scenes/Managers/Main Menu/end_menu.tscn")
	if argument == "clear":
		_correct()
	if argument == "incorrect":
		_incorrect()

func _on_history_button_pressed():
	Dialogic.History.open_history()
