extends Button

export var state_to_set = "MainMenu"
export var use_prev_state = false

func _ready():
	var _err = connect("pressed", self, "_on_self_pressed")
	
	enabled_focus_mode = Control.FOCUS_NONE


func _on_self_pressed():
	if use_prev_state:
		Global.MainMenuNode.next_state = Global.MainMenuNode.prev_state
	else:
		Global.MainMenuNode.next_state = state_to_set
	
	_additional_processing()


func _additional_processing():
	pass