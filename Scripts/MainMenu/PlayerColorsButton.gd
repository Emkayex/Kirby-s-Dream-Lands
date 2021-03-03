extends "res://Scripts/MainMenu/BasicMenuButton.gd"


export var ID: int = 0 # Player ID


func _ready() -> void:
	pass


func _additional_processing() -> void:
	PlayerColors.active_player = ID
