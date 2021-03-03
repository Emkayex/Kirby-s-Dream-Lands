extends CheckBox


func _ready() -> void:
	var _err = connect("toggled", self, "_on_toggle")


func _on_toggle(button_pressed: bool) -> void:
	Server.upnp_port_forward = button_pressed
