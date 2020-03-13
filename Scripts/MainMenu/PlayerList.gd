extends GridContainer

const MENU_FONT = preload("res://Fonts/MainMenuFont.tres")

func _ready():
	var _err = Server.connect("player_connected", self, "_player_connected")
	_err = Server.connect("player_disconnected", self, "_player_disconnected")


func _player_connected(id):
	var PlayerButton = Button.new()
	PlayerButton.set("custom_fonts/font", MENU_FONT)
	PlayerButton.text = str(id)
	PlayerButton.name = str(id)
	PlayerButton.button_mask = 0
	PlayerButton.enabled_focus_mode = Control.FOCUS_NONE
	add_child(PlayerButton)


func _player_disconnected(id):
	for i in get_children():
		if i.name == str(id):
			i.queue_free()
