extends Node

# Main will manage all settings not already handled by a singleton (due to not needing additional functions)
const VIDEO_FILE = "video.kracko"

func _ready():
	Global.Main = self
	Global.spawn_huds()
	
	var _err = $FPSTimer.connect("timeout", self, "_fps_timer_timeout")
	
	Engine.target_fps = 144
	
	Global.initialize_folder(Global.OPTIONS_DIR)
	load_video_settings()


func _fps_timer_timeout():
	$FPSLabel.text = str(Engine.get_frames_per_second())


func load_video_settings():
	var file = File.new()
	var file_path = Global.OPTIONS_DIR + "//" + VIDEO_FILE

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
		print(dataJSON.result)
		
		# Set video settings based upon parsed dict
		$FPSLabel.visible = bool(dataJSON.result["display_fps"])
		OS.window_fullscreen = bool(dataJSON.result["fullscreen"])
	
	# Generate a default bus volume file if one hasn't been created
	else:
		save_video_settings()


func save_video_settings():
	var file = File.new()
	var file_path = Global.OPTIONS_DIR + "//" + VIDEO_FILE
	
	# Assemble a dictionary of the video settings
	var video_dict = {}
	video_dict["display_fps"] = $FPSLabel.visible
	video_dict["fullscreen"] = OS.window_fullscreen
	
	# Bus volumes stored as JSON
	var dataJSON = JSON.print(video_dict)
	
	file.open(file_path, File.WRITE)
	file.store_string(dataJSON)
	file.close()
