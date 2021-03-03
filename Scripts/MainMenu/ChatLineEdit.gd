extends LineEdit


func _ready() -> void:
	var _err = connect("text_entered", self, "_text_entered")


func _text_entered(new_text: String) -> void:
	if (new_text != ""):
		Server.send_msg(new_text)
		text = ""
