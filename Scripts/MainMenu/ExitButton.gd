extends Button

func _ready():
	var _err = connect("pressed", self, "_pressed")


func _pressed():
	get_tree().quit()
