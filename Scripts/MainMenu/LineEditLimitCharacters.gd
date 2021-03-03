extends LineEdit


export var allowed_chars: String = \
		"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 "


func _ready() -> void:
	var _err = connect("text_changed", self, "_on_text_changed")


func _on_text_changed(new_text: String) -> void:
	var cursor_pos: int = caret_position
	var working_string: String = ""
	var bad_char: bool = false
	
	for ch in new_text:
		if ch in allowed_chars:
			working_string += ch
		else:
			bad_char = true
	
	text = working_string
	caret_position = cursor_pos
	
	if bad_char:
		caret_position -= 1
