extends "res://Scripts/MainMenu/BackButtonControls.gd"

func _ready():
	var _err = connect("pressed", self, "_pressed")


func _pressed():
	Global.Main.save_video_settings()
