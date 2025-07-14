extends Node2D

var is_allowed : bool = false
var counter : int = 0

@onready var min1 : Node2D = $Minecart
@onready var min2 : Node2D = $Minecart2
@onready var min3 : Node2D = $Minecart3
@onready var min4 : Node2D = $Minecart4

@onready var timer : Timer = $"Test Completion"

var completed = false

func _ready():
	min1.moved_minecarts.connect(check_completion)
	min2.moved_minecarts.connect(check_completion)
	min3.moved_minecarts.connect(check_completion)
	min4.moved_minecarts.connect(check_completion)
	is_allowed = Dialogic.VAR.get_variable("Actual.Segment 3.puzzle1_completed")
	if Dialogic.VAR.get_variable("Actual.Segment 3.puzzle2_completed") == true:
		completed = true
		print("Does this ever get triggered?")

func check_completion():
	#Check if Puzzle 2 has been completed
	if is_allowed:
		if min1.modus == 3 and min2.modus == 2 and min3.modus == 4 and min4.modus == 1:
			if completed == false:
				$Transitioner.hide()
			Global.minecart_solved = true
			print("Puzzle Completed")
			Dialogic.VAR.set_variable("Actual.Segment 3.puzzle2_progress", 3.0)
			if completed == false:
				timer.start(1.5)
		else:
			if completed == false:
				$Transitioner.show()
			#If the player has 'solved' the puzzle, but disturbs the minecarts.
			if Global.minecart_solved == true:
				print("Disturbed the minecarts after solving the puzzle")
				timer.stop() #Does this trigger the timeout? It shouldn't
				#First time
				Global.minecart_solved = false
				if counter < 1:
					Dialogic.VAR.set_variable("Actual.Segment 3.puzzle2_progress", 2.0)
					counter += 1
				else:
					Dialogic.VAR.set_variable("Actual.Segment 3.puzzle2_progress", 4.0)

func _on_test_completion_timeout():
	$Transitioner.show()
	completed = true
	print("Completed puzzle...")
	Dialogic.start("res://Dialogue/Timelines/Used/Singleton Objects/Segment 3/solved.dtl")
