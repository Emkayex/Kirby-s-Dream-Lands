extends Button


export var player_colors_member_var : String = "type_changing"


func _ready():
	set_process(true)
	var _err = connect("pressed", self, "button_pressed")


func _process(_delta):
	flat = text == PlayerColors.get(player_colors_member_var)


func button_pressed():
	PlayerColors.set(player_colors_member_var, text)
