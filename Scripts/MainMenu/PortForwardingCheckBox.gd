extends CheckBox

func _ready():
	var _err = connect("toggled", self, "_on_toggle")


func _on_toggle(button_pressed):
	Server.upnp_port_forward = button_pressed
