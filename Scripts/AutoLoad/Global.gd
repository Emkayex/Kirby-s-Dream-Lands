extends Node

const OPTIONS_DIR = "user://Options"
const GRAVITY = 600

var Main
var MainMenuNode


func _unused():
	print(MainMenuNode)


# Check if a folder exists yet and create it if it doesn't
func initialize_folder(folder_path):
	var working_dir = Directory.new()
	if not(working_dir.dir_exists(folder_path)):
		working_dir.make_dir(folder_path)


func xor(term_1, term_2):
	return ((term_1 and not(term_2)) or (term_2 and not(term_1)))


func spawn_huds():
	var Hud = load("res://Scenes/Hud/HudLeft.tscn")
	Main.add_child(Hud.instance())
	Hud = load("res://Scenes/Hud/HudRight.tscn")
	Main.add_child(Hud.instance())
