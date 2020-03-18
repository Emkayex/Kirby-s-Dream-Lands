extends Node

const KEYMAP_FILE = "controls.escargoon"

var ActionMap

var PlayerControls = [
	# Player 1 Controls
	{"left" : "", "right" : "", "up" : "", "down" : "",
	"jump" : "", "action" : "", "pause" : "", "eject" : "",
	"spawn" : ""},

	# Player 2 Controls
	{"left" : "", "right" : "", "up" : "", "down" : "",
	"jump" : "", "action" : "", "pause" : "", "eject" : "",
	"spawn" : ""},

	# Player 3 Controls
	{"left" : "", "right" : "", "up" : "", "down" : "",
	"jump" : "", "action" : "", "pause" : "", "eject" : "",
	"spawn" : ""},

	# Player 4 Controls
	{"left" : "", "right" : "", "up" : "", "down" : "",
	"jump" : "", "action" : "", "pause" : "", "eject" : "",
	"spawn" : ""}
]

var ActivePlayer = 0 # Stores which control set is being edited
var ControlToChange = "" # Stores the action being changed


func _unused():
	print(ActivePlayer)
	print(ControlToChange)


# Get the available actions from the InputMap and remove default values
# created on project initialization
func _ready():
	Global.initialize_folder(Global.OPTIONS_DIR)

	ActionMap = InputMap.get_actions()

	# Get the indices of the default InputMap actions and remove them from the ActionMap
	for i in range(ActionMap.size() - 1, 0, -1):
		if ActionMap[i].substr(0, 3) == "ui_":
			ActionMap.remove(i)

	load_controls()


func load_controls():
	var data = Global.load_from_json(Global.OPTIONS_DIR, KEYMAP_FILE)
	
	if data.exists:
		PlayerControls = data.result

	# Generate a default controls file if one hasn't been created
	else:
		save_controls()


func save_controls():
	Global.save_as_json(Global.OPTIONS_DIR, KEYMAP_FILE, PlayerControls)


func get_pressed_key():
	# Scan for a pressed key
	for action in ActionMap:
		if Input.is_action_pressed(action):
			return(action)

	# Return a default key if nothing was pressed
	return("ins")
