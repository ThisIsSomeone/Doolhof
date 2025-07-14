extends Node

### Player ID
@onready var rng = RandomNumberGenerator.new()
var player_id : int = 0

### Global Signals
signal update_score #To update the score displayed on top of the screen
signal grab_timer #Sends a signal to World to give timer back

### Puzzle Tracker
var minecart_solved : bool = false
var area2_entered : bool = false
var area : int = 0 #Corresponds to segment. 0 for introduction, 6 for conclusion.

### Tracker Variables

## Time Tracker
var time : int = 0 #Time Elapsed

## FIRST_TRY
var first_try: int = 0 #How many puzzles were answered correctly on the first try?
var first_try_areas = [false, false, false, false, false, false] #True if completed area on first try without mistakes

## RC_ACCESSED
var rc_accessed: int = 0 #Amount of times Robot Companion was accessed Total
var rc_accessed_areas = [0,0,0,0,0,0]

## AH_ACCESSED
var ah_accessed: int = 0 #Amount of times the Adventurer's Handbook was accessed
var ah_accessed_areas = [0,0,0,0,0,0]

### INCORRECT_ANSWERS
var incorrect_areas = [0,0,0,0,0,0]
var answers_incorrect: int = 0 #Amount of times player answered something incorrectly

### Score Variables
var score: int = 0	 #Player's Current Score
var score_areas = [0,0,0,0,0,0]

var save_string = ''

### Score Functions

#Sends new score to update the UI
func modify_score(modifier: int):
	score = score + modifier
	#Update Area Score
	score_areas[area] = score_areas[area] + modifier 
	#Prevent score from becoming below zero
	if score < 0:
		score = 0
	
	emit_signal("update_score",str(score))

### Tracker Functions

#Update Area
func update_area():
	area += 1
	print("Now entering area: ", area)

#update RC tracker
func update_RC_tracker():
	rc_accessed += 1
	rc_accessed_areas[area] += 1

#update Handbook tracker
func update_handbook_tracker():
	ah_accessed += 1
	ah_accessed_areas[area] += 1

#update First Try
func update_first_try():
	#Only if no mistakes were made in that area
	if incorrect_areas[area] == 0:
		first_try += 1
		first_try_areas[area] = true

#Update incorrect
func update_incorrect():
	incorrect_areas[area] += 1
	answers_incorrect += 1

### Saving the Statistics
func save_to_file():
	var stringy : String = "user://" + str(player_id) + "_save.json"
	var file = FileAccess.open(stringy, FileAccess.WRITE)
	
	emit_signal("grab_timer")
	
	#Calculate leftover variables
	time = 3600.0 - time #total time alloted - time left = time spent. Max time expected is a hour.
	
	#Store all variables
	var content : Dictionary = {
		#Store Scores
		"Total Score": score,
		"A0 Score": score_areas[0],
		"A1 Score": score_areas[1],
		"A2 Score": score_areas[2],
		"A3 Score": score_areas[3],
		#"A4 Score": score_areas[4],
		"A5 Score": score_areas[5],
		
		#Store Robot Companion Accessed
		"RC Accessed Total": rc_accessed,
		"RC Accessed A0": rc_accessed_areas[0],
		"RC Accessed A1": rc_accessed_areas[1],
		"RC Accessed A2": rc_accessed_areas[2],
		"RC Accessed A3": rc_accessed_areas[3],
		#"RC Accessed A4": rc_accessed_areas[4],
		"RC Accessed A5": rc_accessed_areas[5],
		
		#Store Handbook Accessed
		"Handbook Accessed Total": ah_accessed,
		"Handbook Accessed A0": ah_accessed_areas[0],
		"Handbook Accessed A1": ah_accessed_areas[1],
		"Handbook Accessed A2": ah_accessed_areas[2],
		"Handbook Accessed A3": ah_accessed_areas[3],
		#"Handbook Accessed A4": ah_accessed_areas[4],
		"Handbook Accessed A5": ah_accessed_areas[5],
		
		#Store Incorrect Answers
		"Total Incorrect Answers": answers_incorrect,
		"A0 Incorrect Answers:": incorrect_areas[0],
		"A1 Incorrect Answers:": incorrect_areas[1],
		"A2 Incorrect Answers:": incorrect_areas[2],
		#"A3 Incorrect Answers:": incorrect_areas[3],
		#"A4 Incorrect Answers:": incorrect_areas[4],
		"A5 Incorrect Answers:": incorrect_areas[5],
		
		#Store First Tries
		"Total First Tries:": first_try,
		"A0 First Try?": first_try_areas[0],
		"A1 First Try?": first_try_areas[1],
		"A2 First Try?": first_try_areas[2],
		#"A3 First Try?": first_try_areas[3],
		#"A4 First Try?": first_try_areas[4],
		"A5 First Try?": first_try_areas[5],
		
		#Store Time
		"Time Spent": time,
		
		#Store Player ID
		"Player ID": player_id
	}
	file.store_string(JSON.stringify(content))
	print(str(JSON.stringify(content))) #TODO: Remove
	save_string = str(JSON.stringify(content))
