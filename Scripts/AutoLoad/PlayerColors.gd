extends Node


const COLORS_FILE = "colors.spraypaint"


signal player_colors_info_changed


var active_player : int = 0 setget active_player_set # Stores which color set is being edited
var type_changing : String = "Normal" setget type_changing_set
var rank_changing : String = "Primary" setget rank_changing_set


var PlayerColors = [
	# Player 1 Colors
	{"Normal_Primary" : [252, 194, 228], "Normal_Secondary" : [252, 110, 204], "Normal_Tertiary" : [4, 2, 4],
	"Ability_Primary" : [252, 202, 196], "Ability_Secondary" : [252, 130, 116], "Ability_Tertiary" : [4, 2, 4],
	"Ice_Primary" : [252, 254, 252], "Ice_Secondary" : [100, 174, 252], "Ice_Tertiary" : [20, 18, 164]},

	# Player 2 Colors
	{"Normal_Primary" : [0xfe, 0xeb, 0x2d], "Normal_Secondary" : [0xe7, 0x59, 0x19], "Normal_Tertiary" : [0x04, 0x02, 0x04],
	"Ability_Primary" : [0xff, 0xf0, 0x60], "Ability_Secondary" : [0xff, 0x93, 0x62], "Ability_Tertiary" : [0x04, 0x02, 0x04],
	"Ice_Primary" : [0xfc, 0xfc, 0xfc], "Ice_Secondary" : [0x58, 0xf8, 0x98], "Ice_Tertiary" : [0x2e, 0x82, 0x50]},

	# Player 3 Colors
	{"Normal_Primary" : [255, 0, 57], "Normal_Secondary" : [127, 0, 0], "Normal_Tertiary" : [4, 2, 4],
	"Ability_Primary" : [251, 124, 111], "Ability_Secondary" : [196, 26, 6], "Ability_Tertiary" : [4, 2, 4],
	"Ice_Primary" : [240, 224, 232], "Ice_Secondary" : [232, 80, 72], "Ice_Tertiary" : [100, 13, 9]},

	# Player 4 Colors
	{"Normal_Primary" : [131, 130, 132], "Normal_Secondary" : [82, 81, 82], "Normal_Tertiary" : [4, 2, 4],
	"Ability_Primary" : [189, 186, 189], "Ability_Secondary" : [82, 81, 82], "Ability_Tertiary" : [4, 2, 4],
	"Ice_Primary" : [255, 251, 255], "Ice_Secondary" : [255, 0, 57], "Ice_Tertiary" : [82, 81, 82]}
]


func load_colors():
	var data = Global.load_from_json(Global.OPTIONS_DIR, COLORS_FILE)
	
	if data.exists:
		PlayerColors = data.result
	
	# Generate a default controls file if one hasn't been created
	else:
		save_colors()


func save_colors():
	Global.save_as_json(Global.OPTIONS_DIR, COLORS_FILE, PlayerColors)


func active_player_set(id):
	active_player = id
	emit_signal("player_colors_info_changed")


func type_changing_set(type):
	type_changing = type
	emit_signal("player_colors_info_changed")


func rank_changing_set(rank):
	rank_changing = rank
	emit_signal("player_colors_info_changed")

func _ready():
	load_colors()