extends Node


# Each player present on the server gets a SERVER_PLAYER object
const SERVER_PLAYER := preload("res://Scenes/GameObjects/ServerPlayer.tscn")

const PORT: int = 5551 # Known unassigned port safe to use
const MAX_PLAYERS: int = 4 # Limit the number of allowed players to 4
const UPNP_SERVICE_NAME: String = "Kirby's Dream Lands" # How the services appears in router settings


# Booleans for tracking multiplayer status
var online_game: bool = false
var host: bool = true
var connected: bool = false


# Signals emitted by this Singleton
signal player_connected(id)
signal player_disconnected(id)
signal server_shutdown()
signal network_status_update(msg)


func _ready() -> void:
	var _err = get_tree().connect("network_peer_connected", self, "_player_connected")
	_err = get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	_err = get_tree().connect("connected_to_server", self, "_connected_ok")
	_err = get_tree().connect("connection_failed", self, "_connected_fail")
	_err = get_tree().connect("server_disconnected", self, "_server_disconnected")
	pause_mode = PAUSE_MODE_PROCESS


# When a player connected, create a SERVER_PLAYER object for them and add it to the scene tree
func _player_connected(id: int) -> void:
	var ServerPlayer = SERVER_PLAYER.instance()
	ServerPlayer.name = str(id)
	ServerPlayer.network_id = id # Set the network ID variable
	ServerPlayer.set_network_master(id) # Set the connecting player to be the master of their own object
	add_child(ServerPlayer)
	
	# Previously would assign a player ID to each connecting player (0 through 3)
	# However, that adds extra complexity
	# Since player order does not matter (besides the server who is always 1) sort player order by network ID
	
	emit_signal("player_connected", id)


# Unregister a player and remove them from the players list when someone disconnects
func _player_disconnected(id: int) -> void:
	for ServerPlayer in get_children():
		if ServerPlayer.network_id == id:
			remove_child(ServerPlayer)
			emit_signal("player_disconnected", id)


func _connected_ok():
	pass


func _connected_fail():
	pass


# Unregister all players if the server goes down
func _server_disconnected():
	get_tree().set_network_peer(null)
	connected = false
	
	for ServerPlayer in get_children():
		_player_disconnected(ServerPlayer.network_id)
	
	emit_signal("server_shutdown")
