extends CheckBox

func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	_start_delay_timeout()


func _check_toggled(button_pressed):
	OS.window_fullscreen = button_pressed


func _start_delay_timeout():
	pressed = OS.window_fullscreen
	
	var _err = connect("toggled", self, "_check_toggled")