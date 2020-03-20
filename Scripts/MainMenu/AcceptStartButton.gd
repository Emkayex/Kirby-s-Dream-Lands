extends Button

export var state_to_set : String = "MainMenu"
export var new_game_button : bool = false
export var file_name_line_edit : NodePath

func _ready():
	var _err = connect("pressed", self, "_on_self_pressed")


func _on_self_pressed():
	if new_game_button:
		SaveData.CurrentSaveData.file_name = get_node(file_name_line_edit).get("text")
		get_node(file_name_line_edit).set("text", "")
		SaveData.create_new_file()
	
	if Server.online_game:
		Global.MainMenuNode.next_state = state_to_set
	else:
		Global.Main.start_game()
