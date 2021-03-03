extends "res://Scripts/MainMenu/BasicMenuButton.gd"


func _ready() -> void:
	pass


func _additional_processing() -> void:
	Sound.save_volumes()
