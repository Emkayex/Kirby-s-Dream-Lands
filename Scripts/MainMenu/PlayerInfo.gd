extends Sprite

var network_id : int = -1
var player_id : int = 0

func _ready():
	var _err = $KirbyButton.connect("pressed", self, "_on_kirby_pressed")
	
	var user_name_node = $KirbyButton/VBoxContainer/UserNameButton
	
	if get_tree().get_network_unique_id() != 1:
		$KirbyButton/VBoxContainer/KickButton.queue_free()
	else:
		_err = $KirbyButton/VBoxContainer/KickButton.connect("pressed", self, "_on_kick_pressed")
	
	#TODO: Assign player IDs
	print("TODO: Assign player IDs")
	
	# Set the necessary colors in the shader
	var colors = PlayerColors.get_colors(player_id, "Normal")
	material.set_shader_param("replacement_color_1", colors[0])
	material.set_shader_param("replacement_color_2", colors[1])
	material.set_shader_param("replacement_color_3", colors[2])


func _on_kirby_pressed():
	$KirbyButton/VBoxContainer.visible = not($KirbyButton/VBoxContainer.visible)


func _on_kick_pressed():
	print("Kick pressed")
