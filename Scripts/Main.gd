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
	var data = Global.load_from_json(Global.OPTIONS_DIR, VIDEO_FILE)
	
	# Set video settings based upon parsed dict
	if data.exists:
		$FPSLabel.visible = bool(data.result["display_fps"])
		OS.window_fullscreen = bool(data.result["fullscreen"])
	
	# Generate a default video settings file if one hasn't been created
	else:
		save_video_settings()


func save_video_settings():
	# Assemble a dictionary of the video settings
	var video_dict = {}
	video_dict["display_fps"] = $FPSLabel.visible
	video_dict["fullscreen"] = OS.window_fullscreen
	
	Global.save_as_json(Global.OPTIONS_DIR, VIDEO_FILE, video_dict)


func start_game():
	print("Starting Game (STUB)")
