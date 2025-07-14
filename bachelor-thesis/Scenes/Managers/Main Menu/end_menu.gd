extends Control

@onready var main : Node = $"Main Screen"
@onready var credits : Node = $Credits

@onready var user_data : Node = $"User Data"
@onready var data_string : RichTextLabel = $"User Data/LeftPage/MarginContainer/VBoxContainer/RichTextLabel"

#Ga naar Enquette
func _on_start_pressed():
	OS.shell_open("https://leidenuniv.eu.qualtrics.com/jfe/form/SV_4NMEteUgJWviAzc") #TODO: CHange, this is the link for the playtesters!!

#Open File Systeem
func _on_open_filesysteem_pressed():
	print(OS.get_user_data_dir())
	OS.shell_open(OS.get_user_data_dir())

#Ga naar Credits
func _on_credits_pressed():
	main.hide()
	credits.show()

#Hide Credits en Terug naar Hoofdmenu
func _on_button_pressed():
	credits.hide()
	main.show()

func _on_copy_user_data_pressed():
	DisplayServer.clipboard_set(Global.save_string)


func _on_copy_user_data_2_pressed():
	data_string.text = Global.save_string
	user_data.show()
	main.hide()
	
func _on_hide_pressed():
	user_data.hide()
	main.show()
