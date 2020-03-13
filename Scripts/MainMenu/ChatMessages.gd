extends RichTextLabel

func _ready():
	var _err = Server.connect("msg_received", self, "_msg_received")


func _msg_received(user : String, text_in : String) -> void:
	text += ("\n" + user + " - " + text_in)
