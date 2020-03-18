extends "res://Scripts/MainMenu/BasicMenuButton.gd"

export var set_online_game : bool = true


func _ready():
	pass


func _additional_processing():
	Server.online_game = set_online_game
