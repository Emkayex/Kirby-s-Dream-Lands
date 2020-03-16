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


func save_as_json(folder_path : String, file_name : String, dataStruct):
	# Check if the folder to save in exists first
	initialize_folder(folder_path)
	
	# Create the file object for writing data
	var file = File.new()
	var file_path = folder_path + "//" + file_name
	
	# Dictionary stored as JSON
	var dataJSON = JSON.print(dataStruct)
	
	# Write the JSON to a file
	file.open(file_path, File.WRITE)
	file.store_string(dataJSON)
	file.close()


func load_from_json(folder_path : String, file_name : String) -> Dictionary:
	var file = File.new()
	var file_path = folder_path + "//" + file_name

	# Create variable to hold parsed JSON data
	var dataJSON = JSONParseResult.new()
	
	# Create a dictionary to return relevant information
	var returnData = {
		"result" : "",
		"exists" : false
	}

	# Check if the file has already been generated from a previous game
	if file.file_exists(file_path):

		# Load raw text from the specified file
		file.open(file_path, File.READ)
		var content = file.get_as_text()
		file.close()

		# Parse raw text as JSON
		dataJSON = JSON.parse(content)
		
		returnData.result = dataJSON.result
		returnData.exists = true
	
	return returnData


func xor(term_1, term_2):
	return ((term_1 and not(term_2)) or (term_2 and not(term_1)))


func spawn_huds():
	var Hud = load("res://Scenes/Hud/HudLeft.tscn")
	Main.add_child(Hud.instance())
	Hud = load("res://Scenes/Hud/HudRight.tscn")
	Main.add_child(Hud.instance())
