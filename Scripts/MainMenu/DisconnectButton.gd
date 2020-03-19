extends "res://Scripts/MainMenu/BasicMenuButton.gd"

export var server_status_label : NodePath

func _ready():
	pass


func _additional_processing():
	Server.connected = false
	
	# Close the server if the player is the host
	if get_tree().get_network_unique_id() == 1:
		Server.close_server(get_node(server_status_label))
	
	else:
		Server.disconnect_from_server(get_node(server_status_label))
