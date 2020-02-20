extends Control

const ON_POS = Vector2(0, 0)
const OFF_POS = Vector2(1000, 1000)

var prev_state = "MainMenu"
var state = "MainMenu"
var next_state = "MainMenu"

func _ready():
	set_physics_process(true)
	Global.MainMenuNode = self
	set_menu_visibility()


func _physics_process(_delta):
	if next_state != state:
		prev_state = state
		state = next_state
		set_menu_visibility()


# Show/hide and enable/disable controls as the state changes
func set_menu_visibility():
	for child in get_children():
		if child.name.ends_with("Set"):
			if child.name == (state + "Set"):
				child.visible = true
				child.position = ON_POS
				set_children_controls_disabled_state(false, child)
			else:
				child.visible = false
				child.position = OFF_POS
				set_children_controls_disabled_state(true, child)


# Recursively iterates through all child nodes and disables/enables control if property is defined
func set_children_controls_disabled_state(is_disabled, base_node):
	for child in base_node.get_children():
		if child.get("disabled") != null:
			child.disabled = is_disabled
		set_children_controls_disabled_state(is_disabled, child)