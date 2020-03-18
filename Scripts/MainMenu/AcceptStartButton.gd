extends Button

export var state_to_set : String = "MainMenu"

func _ready():
	var _err = connect("pressed", self, "_on_self_pressed")


func _on_self_pressed():
	if Server.online_game:
		Global.MainMenuNode.next_state = state_to_set
	else:
		Global.Main.start_game()
