extends "res://Scripts/MainMenu/BasicMenuButton.gd"


func _ready() -> void:
	pass


func _additional_processing() -> void:
	Keymap.save_controls()
