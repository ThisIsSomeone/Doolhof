extends "res://Entities/NPC/npc.gd"

func _on_click():
	super()
	#Start Dialogue
	#TODO: Test updater of score
	Global.modify_score(500)
	Dialogic.start("res://Dialogue/Timelines/Prototypes/tester_timeline.dtl")
	#TODO: After timeline is over, lose 250 points to test if that works
	Global.modify_score(-250)
	#This works just fine but mind that the commands are executed synchronously, Dialogic.start does not interrupt the script apparently
