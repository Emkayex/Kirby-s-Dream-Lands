extends Node


const OPTIONS_DIR: String = "user://Options"
const GRAVITY: int = 600

var Main: Node
var MainMenuNode: Node


func _unused() -> void:
	print(MainMenuNode)


# Check if a folder exists yet and create it if it doesn't
func initialize_folder(folder_path: String) -> void:
	var working_dir = Directory.new()
	if not(working_dir.dir_exists(folder_path)):
		working_dir.make_dir(folder_path)


func save_as_json(folder_path: String, file_name: String, dataStruct) -> void:
	# Check if the folder to save in exists first
	initialize_folder(folder_path)
	
	# Create the file object for writing data
	var file = File.new()
	var file_path = folder_path + "//" + file_name
	
	# Dictionary stored as JSON
	var dataJSON = JSON.print(dataStruct)
	dataJSON = format_json(dataJSON)
	
	# Write the JSON to a file
	file.open(file_path, File.WRITE)
	file.store_string(dataJSON)
	file.close()


func load_from_json(folder_path: String, file_name: String) -> Dictionary:
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


func format_json(jsonString: String) -> String:
	var returnString = jsonString.replacen("{", "{\n")
	returnString = returnString.replacen("}", "\n}")
	returnString = returnString.replacen("[", "[\n")
	returnString = returnString.replacen("]", "\n]")
	returnString = returnString.replacen(",", ",\n")
	
	return returnString


func xor(term_1: bool, term_2: bool) -> bool:
	return ((term_1 and not(term_2)) or (term_2 and not(term_1)))


func spawn_huds() -> void:
	var Hud = load("res://Scenes/Hud/HudLeft.tscn")
	Main.add_child(Hud.instance())
	Hud = load("res://Scenes/Hud/HudRight.tscn")
	Main.add_child(Hud.instance())
