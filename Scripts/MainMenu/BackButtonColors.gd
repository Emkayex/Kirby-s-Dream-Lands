extends "res://Scripts/MainMenu/BasicMenuButton.gd"


func _ready() -> void:
	pass


func _additional_processing() -> void:
	PlayerColors.save_colors()
	PlayerColors.type_changing = "Normal"
	PlayerColors.rank_changing = "Primary"
