# Base class for all player controlled characters

#extends "res://Scripts/GameObjects/CharacterActor.gd"
extends CharacterActor

class_name Player

# ID of player and whether player is local
var player_id : int = 0
var local_player : bool = true

# Controls set in Keymap.gd singleton
var controls = {}

func _ready():
	add_to_group("players")
	
	# Set controls if player is local (therefore has ID between 0 and 3)
	if (local_player):
		controls = Keymap.PlayerControls[player_id]
