extends Control

var network_id : int = -1
var player_id : int = 0
var kirby_colors = []
var user_name : String = ""
var kirby_name : String = ""

func _ready():
	var _err = $KirbySprite/KirbyButton.connect("pressed", self, "_on_kirby_pressed")
	
	if get_tree().get_network_unique_id() != 1:
		$KirbySprite/KirbyButton/VBoxContainer/KickButton.queue_free()
	else:
		_err = $KirbySprite/KirbyButton/VBoxContainer/KickButton.connect("pressed", self, "_on_kick_pressed")
	
	# Set the necessary colors in the shader
	$KirbySprite.material.set_shader_param("replacement_color_1", kirby_colors[0])
	$KirbySprite.material.set_shader_param("replacement_color_2", kirby_colors[1])
	$KirbySprite.material.set_shader_param("replacement_color_3", kirby_colors[2])
	
	$KirbySprite/KirbyButton/VBoxContainer/UserNameButton.text = user_name
	$KirbySprite/KirbyButton.text = kirby_name


func _on_kirby_pressed():
	$KirbySprite/KirbyButton/VBoxContainer.visible = not($KirbySprite/KirbyButton/VBoxContainer.visible)


func _on_kick_pressed():
	print("Kick pressed")
