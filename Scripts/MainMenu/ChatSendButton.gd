extends Button

export var ChatLineEditPath : NodePath

func _ready():
	var _err = connect("pressed", self, "_on_pressed")


func _on_pressed():
	get_node(ChatLineEditPath).call_deferred("_text_entered")
