extends Label


export var label_to_copy: NodePath


func _ready() -> void:
	set_process(true)


func _process(_delta: float) -> void:
	text = get_node(label_to_copy).get("text")
