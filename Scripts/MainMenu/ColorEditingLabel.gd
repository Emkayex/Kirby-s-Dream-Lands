extends Label


func _ready() -> void:
	set_process(true)


func _process(_delta: float) -> void:
	text = "Editing " + PlayerColors.type_changing + " " + PlayerColors.rank_changing
