extends Node

const SAVE_DIR = "user://SavedGames"

var saved_games = {}

func _ready():
	initialize_save_folder()
	retrieve_saved_games()


# Check if a saved games folder exists yet and create it if it doesn't
func initialize_save_folder():
	var working_dir = Directory.new()
	if not(working_dir.dir_exists(SAVE_DIR)):
		working_dir.make_dir(SAVE_DIR)


# Iterate through the saved games list and retrieve all file names and associated games
func retrieve_saved_games():
	saved_games = {} # Start by clearing the current list of saved games
	
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