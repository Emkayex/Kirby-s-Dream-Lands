extends Button

export var chat_line_edit_path : NodePath

func _ready():
	var _err = connect("pressed", self, "_on_pressed")


func _on_pressed():
	get_node(chat_line_edit_path).call_deferred("_text_entered")
