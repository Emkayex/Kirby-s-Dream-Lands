extends Sprite


func _ready():
	set_process(true)


func _process(_delta):
	var dict_key : String = PlayerColors.type_changing + "_"

	var primary_string : String = ""
	var secondary_string : String = ""
	var tertiary_string : String = ""

	# Get RGB value as hex string for primary color
	for i in range(3):
		primary_string += "%02x" % PlayerColors.PlayerColors[PlayerColors.active_player][dict_key + "Primary"][i]

	# Get RGB value as hex string for secondary color
	for i in range(3):
		secondary_string += "%02x" % PlayerColors.PlayerColors[PlayerColors.active_player][dict_key + "Secondary"][i]

	# Get RGB value as hex string for tertiary color
	for i in range(3):
		tertiary_string += "%02x" % PlayerColors.PlayerColors[PlayerColors.active_player][dict_key + "Tertiary"][i]

	var p_color : Color = Color(primary_string)
	var s_color: Color = Color(secondary_string)
	var t_color : Color = Color(tertiary_string)

	# Set the necessary colors in the shader
	material.set_shader_param("replacement_color_1", p_color)
	material.set_shader_param("replacement_color_2", s_color)
	material.set_shader_param("replacement_color_3", t_color)
