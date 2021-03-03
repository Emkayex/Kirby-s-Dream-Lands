extends "res://Scripts/MainMenu/BasicMenuButton.gd"


export var ID: int = 0 # Player ID


func _ready() -> void:
	pass


func _additional_processing() -> void:
	Keymap.ActivePlayer = ID
	
	var ControlIndicators = "SetControlsSet/ScrollContainer/HBoxContainer/ControlIndicators"
	
	if Global.MainMenuNode.has_node(ControlIndicators):
		for i in Global.MainMenuNode.get_node(ControlIndicators).get_children():
			i.text = Keymap.PlayerControls[Keymap.ActivePlayer][i.name]
