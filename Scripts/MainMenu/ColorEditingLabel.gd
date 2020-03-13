extends Label

func _ready():
	set_process(true)


func _process(_delta):
	text = "Editing " + PlayerColors.type_changing + " " + PlayerColors.rank_changing
