extends Button

var SettingControl = false # Indicates if the button was pressed to change the control


func _ready():
	var _err = connect("pressed", self, "_on_self_pressed")
	
	self.enabled_focus_mode = Control.FOCUS_NONE


func _on_self_pressed():
	SettingControl = true
	Keymap.ControlToChange = self.name
	
	# Disable back button while setting controls
	get_parent().get_parent().get_parent().get_parent().get_node("BackButton").disabled = true


func _input(event):
	# Filter mouse events when changing controls
	if not((event is InputEventMouseMotion) or (event is InputEventMouseButton)):
		if SettingControl:
			SettingControl = false
			
			# Set the control and label
			Keymap.PlayerControls[Keymap.ActivePlayer][Keymap.ControlToChange] = Keymap.get_pressed_key()
			self.text = Keymap.PlayerControls[Keymap.ActivePlayer][Keymap.ControlToChange]
			
			# Enable back button after setting a control
			get_parent().get_parent().get_parent().get_parent().get_node("BackButton").disabled = false