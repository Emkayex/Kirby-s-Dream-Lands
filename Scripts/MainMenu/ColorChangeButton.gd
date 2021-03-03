extends Button


export var player_colors_member_var: String = "type_changing"


func _ready() -> void:
	set_process(true)
	var _err = connect("pressed", self, "button_pressed")


func _process(_delta: float) -> void:
	flat = text == PlayerColors.get(player_colors_member_var)


func button_pressed() -> void:
	PlayerColors.set(player_colors_member_var, text)
