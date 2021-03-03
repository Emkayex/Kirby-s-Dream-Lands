extends HSlider


export var color_id: int = 0
var can_change: bool = true # Workaround variable to prevent overwriting colors when switching IDs


func _ready() -> void:
	var _err = connect("value_changed", self, "slider_value_changed")
	_err = PlayerColors.connect("player_colors_info_changed", self, "update_slider_info")


func slider_value_changed(value: float) -> void:
	var new_value: float = round(value)
	
	# Update the text label
	$ValueLabel.text = str(new_value)
	
	# Build the dictionary key
	var dict_key : String = PlayerColors.type_changing + "_" + PlayerColors.rank_changing
	
	# Set the new color for the player in the PlayerColors singleton
	if (can_change):
		PlayerColors.PlayerColors[PlayerColors.active_player][dict_key][color_id] = new_value


func update_slider_info() -> void:
	value = PlayerColors.PlayerColors[PlayerColors.active_player][PlayerColors.type_changing + "_" + PlayerColors.rank_changing][color_id]
