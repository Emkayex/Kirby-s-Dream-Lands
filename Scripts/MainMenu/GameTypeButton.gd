extends "res://Scripts/MainMenu/BasicMenuButton.gd"


export var set_online_game: bool = true


func _ready() -> void:
	pass


func _additional_processing() -> void:
	Server.online_game = set_online_game
