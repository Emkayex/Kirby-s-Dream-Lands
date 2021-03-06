extends Node


const SAVE_DIR: String = "user://SavedGames"

var SavedGames: Dictionary = {}

var CurrentSaveData: Dictionary = {
	"game_name" : "",
	"file_name" : ""
}


func _ready() -> void:
	Global.initialize_folder(SAVE_DIR)
	retrieve_saved_games()


func create_new_file() -> void:
	print("Creating File (STUB)")


# Iterate through the saved games list and retrieve all file names and associated games
func retrieve_saved_games() -> void:
	SavedGames = {} # Start by clearing the current list of saved games
	
	# Open the SavedGames directory
	var working_dir = Directory.new()
	working_dir.open(SAVE_DIR)
	working_dir.list_dir_begin(true)
	
	# Go through all files in SavedGames directory
	var next_file = working_dir.get_next()
	while (next_file != ""):
		print(next_file)
		next_file = working_dir.get_next()
	working_dir.list_dir_end() # Close the filestream
