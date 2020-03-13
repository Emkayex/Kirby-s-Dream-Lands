extends "res://Scripts/MainMenu/BasicMenuButton.gd"

export var ID = 0 # Player ID

func _ready():
	pass

func _additional_processing():
	PlayerColors.active_player = ID
