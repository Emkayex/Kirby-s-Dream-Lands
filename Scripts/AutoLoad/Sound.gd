extends Node

const VOLUME_FILE = "volume.dedede"
const MAX_SLIDER_VALUE = 10000

func _ready():
	Global.initialize_folder(Global.OPTIONS_DIR)
	load_volumes()


func load_volumes():
	var file = File.new()
	var file_path = Global.OPTIONS_DIR + "//" + VOLUME_FILE

	# Create variable to hold parsed JSON data
	var dataJSON = JSONParseResult.new()

	# Check if the controls file has already been generated from a previous game
	if file.file_exists(file_path):

		# Load raw text from controls file
		file.open(file_path, File.READ)
		var content = file.get_as_text()
		file.close()

		# Parse raw text as JSON
		dataJSON = JSON.parse(content)

		# Set the bus volumes to the values in the parsed JSON
		for bus in range(0, dataJSON.result.size()):
			AudioServer.set_bus_volume_db(bus, dataJSON.result[bus])

	# Generate a default bus volume file if one hasn't been created
	else:
		save_volumes()


func save_volumes():
	var file = File.new()
	var file_path = Global.OPTIONS_DIR + "//" + VOLUME_FILE
	
	# Create an array of audio bus values where indices correspond to bus indices
	var volume_array = []
	
	for bus in range(0, AudioServer.get_bus_count()):
		volume_array.append(AudioServer.get_bus_volume_db(bus))
	
	# Bus volumes stored as JSON
	var dataJSON = JSON.print(volume_array)
	
	file.open(file_path, File.WRITE)
	file.store_string(dataJSON)
	file.close()