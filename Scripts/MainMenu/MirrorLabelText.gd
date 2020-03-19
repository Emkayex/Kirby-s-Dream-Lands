extends Label

export var label_to_copy : NodePath

func _ready():
	set_process(true)


func _process(_delta):
	text = get_node(label_to_copy).get("text")
