extends LineEdit

func _ready():
	connect("text_entered", self, "_text_entered")


func _text_entered(new_text):
	Server.send_msg(new_text)
	text = ""
