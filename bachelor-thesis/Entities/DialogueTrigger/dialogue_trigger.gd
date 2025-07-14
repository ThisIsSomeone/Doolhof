extends "res://Entities/NPC/npc.gd"

@export_file("*.dtl") var path : String
signal trigger_dialogue

func _on_click():
	super()
	#Start Dialogue
	Dialogic.start(ResourceUID.get_id_path(ResourceUID.text_to_id(path))) #Convert UID into String
	emit_signal("trigger_dialogue")
