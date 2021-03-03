extends Node


const VOLUME_FILE: String = "volume.dedede"
const MAX_SLIDER_VALUE: int = 10000


func _ready() -> void:
	Global.initialize_folder(Global.OPTIONS_DIR)
	load_volumes()


func load_volumes() -> void:
	var data = Global.load_from_json(Global.OPTIONS_DIR, VOLUME_FILE)
	
	if data.exists:
		# Set the bus volumes to the values in the parsed JSON
		for bus in range(0, data.result.size()):
			AudioServer.set_bus_volume_db(bus, data.result[bus])
	
	# Generate a default bus volume file if one hasn't been created
	else:
		save_volumes()



func save_volumes() -> void:
	# Create an array of audio bus values where indices correspond to bus indices
	var volume_array = []
	
	for bus in range(0, AudioServer.get_bus_count()):
		volume_array.append(AudioServer.get_bus_volume_db(bus))
	
	Global.save_as_json(Global.OPTIONS_DIR, VOLUME_FILE, volume_array)
