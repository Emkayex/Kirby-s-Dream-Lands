extends "res://Scripts/MainMenu/BasicMenuButton.gd"

func _ready():
	pass


func _additional_processing():
	Keymap.save_controls()
