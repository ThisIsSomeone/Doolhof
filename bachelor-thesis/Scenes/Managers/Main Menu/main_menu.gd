extends Control

@onready var main : Node = $"Main Screen"
@onready var credits : Node = $Credits

#Start Game
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Managers/Game/world.tscn")

#Ga naar Credits
func _on_credits_pressed():
	main.hide()
	credits.show()

#Sluit Game
func _on_quit_pressed():
	get_tree().quit()

#Hide Credits en Terug naar Hoofdmenu
func _on_button_pressed():
	credits.hide()
	main.show()
