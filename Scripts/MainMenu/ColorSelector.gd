extends VSlider

export var paired_slider : NodePath
export var player_label : NodePath

func _ready():
	var _err = connect("value_changed", self, "_on_value_changed")


func _on_value_changed(value):
	PlayerColors.online_color_id = value - 1
	
	get_node(player_label).set("text", "Player " + str(value))
	get_node(paired_slider).set("value", value)
