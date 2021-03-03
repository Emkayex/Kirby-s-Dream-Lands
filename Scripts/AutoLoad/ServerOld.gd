extends Node


const SERVER_PLAYER := preload("res://Scenes/GameObjects/ServerPlayer.tscn")

const PORT: int = 5551 # Known unassigned port safe to use
const MAX_PLAYERS: int = 4 # Limit the number of allowed players to 4
const UPNP_SERVICE_NAME: String = "Kirby's Dream Lands" # How the services appears in router settings

var online_game: bool = false

var upnp_port_forward: bool = false
var connected: bool = false

var network_name: String = ""
var character_name: String = ""

signal player_connected(id)
signal player_disconnected(id)
signal msg_received(user, text)
signal player_info_received(player_node)


func _ready() -> void:
	var _err = get_tree().connect("network_peer_connected", self, "_player_connected")
	_err = get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	_err = get_tree().connect("connected_to_server", self, "_connected_ok")
	_err = get_tree().connect("connection_failed", self, "_connected_fail")
	_err = get_tree().connect("server_disconnected", self, "_server_disconnected")
	pause_mode = PAUSE_MODE_PROCESS


# Register a new user when they connect
func _player_connected(id: int) -> void:
	var Player = SERVER_PLAYER.instance()
	Player.name = str(id)
	add_child(Player)
	
	# Assign the network ID variable
	Player.network_id = id
	
	# The server should determine which player ID to assign and distribute it
	if get_tree().get_network_unique_id() == 1:
		var current_player_ids = []
		for child in get_children():
			current_player_ids.append(child.player_id)
		
		# Increment the player_index until an unused ID is reached
		# The server settings prevent more than 4 players from joining
		var player_index : int = 0
		while player_index in current_player_ids:
			player_index += 1
		
		rpc("assign_id", player_index, id)
	
	emit_signal("player_connected", id)


# Unregister a user when they disconnect
func _player_disconnected(id: int) -> void:
	for Player in get_children():
		if Player.name == str(id):
			remove_child(Player)
			emit_signal("player_disconnected", id)


func _connected_ok() -> void:
	pass


func _connected_fail() -> void:
	pass


func _server_disconnected() -> void:
	get_tree().set_network_peer(null)
	connected = false
	
	# Must unregister all players if server disconnects
	for i in get_children():
		_player_disconnected(int(i.name))


# Attempt to start a server on default port with limited number of clients
func start_server(NetworkStatusNode: Node, user_name: String, kirby_name: String) -> int:
	# First check for a user name and Kirby name
	if user_name == "":
		NetworkStatusNode.text = "Enter a User Name"
		return 1
	if kirby_name == "":
		NetworkStatusNode.text = "Enter a Kirby Name"
		return 1
	
	# Set user name and character name
	network_name = user_name
	character_name = kirby_name
	
	# First open the UPNP port if requested by the user
	var upnp_successful = false
	if upnp_port_forward:
		var upnp = UPNP.new()
		upnp.discover()
		
		# Add port mappings
		if upnp.get_gateway() and upnp.get_gateway().is_valid_gateway():
			var udp_status = upnp.add_port_mapping(PORT, PORT, UPNP_SERVICE_NAME, "UDP")
			var tcp_status = upnp.add_port_mapping(PORT, PORT, UPNP_SERVICE_NAME, "TCP")
			
			# Check return codes from adding port mappings
			if (udp_status == upnp.UPNP_RESULT_SUCCESS) and (tcp_status == upnp.UPNP_RESULT_SUCCESS):
				upnp_successful = true
	
	
	# Host the server
	var peer = NetworkedMultiplayerENet.new()
	var err = peer.create_server(PORT, MAX_PLAYERS) # Check for errors when starting server
	if (err != OK):
		NetworkStatusNode.text = "Error Starting Server"
		return 1
	else:
		get_tree().set_network_peer(peer)
		
		_player_connected(1) # Master always has an ID of 1
		
		if upnp_port_forward and not(upnp_successful):
			NetworkStatusNode.text = "Server Started, Port Forward Failed"
		else:
			NetworkStatusNode.text = "Server Started"
		return 0


func close_server(NetworkStatusNode: Node) -> void:
	get_tree().set_network_peer(null)
	NetworkStatusNode.text = "Disconnected"
	
	# Must unregister all players if server stops hosting
	for i in get_children():
		_player_disconnected(int(i.name))
	
	# Always attempt to close any ports opened by the program as a security measure
	var upnp = UPNP.new()
	upnp.discover()
	
	# Delete port mappings
	if upnp.get_gateway() and upnp.get_gateway().is_valid_gateway():
		upnp.delete_port_mapping(PORT, "UDP")
		upnp.delete_port_mapping(PORT, "TCP")


func connect_to_ip(ip: String, NetworkStatusNode: Node, user_name: String, kirby_name: String) -> int:
	# Perform error checking and return error status if necessary
	if user_name == "":
		NetworkStatusNode.text = "Enter a User Name"
		return 1
	if kirby_name == "":
		NetworkStatusNode.text = "Enter a Kirby Name"
		return 1
	if not(ip.is_valid_ip_address()):
		NetworkStatusNode.text = "Invalid IP Address"
		return 1
	
	# Set user name and character name
	network_name = user_name
	character_name = kirby_name
	
	# Establish connection
	var peer = NetworkedMultiplayerENet.new()
	var error = peer.create_client(ip, PORT)
	
	if (error == OK):
		get_tree().set_network_peer(peer)
		NetworkStatusNode.text = "Connected"
		_player_connected(get_tree().get_network_unique_id())
		return 0
	else:
		NetworkStatusNode.text = "No Server Found"
		return 1


func disconnect_from_server(NetworkStatusNode: Node) -> void:
	get_tree().set_network_peer(null)
	NetworkStatusNode.text = "Disconnected"
	
	# Must unregister all players if server stops hosting
	for i in get_children():
		_player_disconnected(int(i.name))


func send_msg(text: String) -> void:
	rpc("receive_msg", network_name, text)


remotesync func receive_msg(user: String, text: String) -> void:
	emit_signal("msg_received", user, text)


remotesync func assign_id(player_id: int, network_id: int) -> void:
	for child in get_children():
		if child.network_id == network_id:
			child.player_id = player_id
	
	var colors = PlayerColors.PlayerColors[PlayerColors.online_color_id]
	rpc("set_player_info", get_tree().get_network_unique_id(), network_name, character_name, colors)


remotesync func set_player_info(sender_network_id: int, user_name: String, kirby_name: String, colors: Array) -> void:
	var node_to_change : Node
	
	# Determine which player's info to update
	for child in get_children():
		if child.network_id == sender_network_id:
			# Update names
			child.user_name = user_name
			child.kirby_name = kirby_name
			
			# Update color information
			child.kirby_colors = colors
			PlayerColors.ActivePlayerColors[child.player_id] = colors
			
			node_to_change = child
	
	emit_signal("player_info_received", node_to_change)
