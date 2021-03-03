extends VBoxContainer


const PLAYER_INFO := preload("res://Scenes/Menus/PlayerInfoNew.tscn")


func _ready() -> void:
	var _err = Server.connect("player_disconnected", self, "_player_disconnected")
	_err = Server.connect("player_info_received", self, "_player_info_received")


func _player_info_received(player: Node) -> void:
	var add_player: bool = true
	
	for child in get_children():
		if child.name == player.name:
			add_player = false
	
	if add_player:
		var player_listing = PLAYER_INFO.instance()
		player_listing.name = str(player.network_id)
		player_listing.kirby_colors = PlayerColors.get_colors(player.player_id, "Normal")
		player_listing.network_id = player.network_id
		player_listing.player_id = player.player_id
		player_listing.user_name = player.user_name
		player_listing.kirby_name = player.kirby_name
		add_child(player_listing)


func _player_disconnected(id: int) -> void:
	for i in get_children():
		if i.name == str(id):
			i.queue_free()
