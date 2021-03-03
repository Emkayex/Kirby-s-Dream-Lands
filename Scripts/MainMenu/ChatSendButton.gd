extends Button


export var chat_line_edit_path: NodePath


func _ready() -> void:
	var _err = connect("pressed", self, "_on_pressed")


func _on_pressed() -> void:
	var par = get_node(chat_line_edit_path)
	par.call("_text_entered", par.get("text"))
