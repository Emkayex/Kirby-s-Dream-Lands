extends "res://Scripts/MainMenu/BasicMenuButton.gd"


func _ready():
	pass


func _additional_processing():
	PlayerColors.save_colors()
	PlayerColors.type_changing = "Normal"
	PlayerColors.rank_changing = "Primary"
