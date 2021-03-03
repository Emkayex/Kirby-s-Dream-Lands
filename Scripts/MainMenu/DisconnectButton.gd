extends "res://Scripts/MainMenu/BasicMenuButton.gd"


export var server_status_label: NodePath
export var chat_line_edit: NodePath
export var chat_box: NodePath


func _ready() -> void:
	pass


func _additional_processing() -> void:
	Server.connected = false
	
	# Close the server if the player is the host
	if get_tree().get_network_unique_id() == 1:
		Server.close_server(get_node(server_status_label))
	
	else:
		Server.disconnect_from_server(get_node(server_status_label))
	
	# Clear the chat boxes
	get_node(chat_line_edit).set("text", "")
	get_node(chat_box).set("text", "")
