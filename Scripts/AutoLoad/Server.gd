extends Node

const PORT = 5551 # Known unassigned port safe to use
const MAX_PLAYERS = 4 # Limit the number of allowed players to 4
const UPNP_SERVICE_NAME = "Kirby's Dream Lands"

var upnp_port_forward = false
var connected = false

var network_name = ""
var character_name = ""

signal player_connected(id)
signal player_disconnected(id)
signal msg_received(user, text)

func _ready():
	var _err = get_tree().connect("network_peer_connected", self, "_player_connected")
	_err = get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	_err = get_tree().connect("connected_to_server", self, "_connected_ok")
	_err = get_tree().connect("connection_failed", self, "_connected_fail")
	_err = get_tree().connect("server_disconnected", self, "_server_disconnected")
	pause_mode = PAUSE_MODE_PROCESS


# Register a new user when they connect
func _player_connected(id):
	var Player = Node.new()
	Player.name = str(id)
	add_child(Player)
	emit_signal("player_connected", id)


# Unregister a user when they disconnect
func _player_disconnected(id):
	for Player in get_children():
		if Player.name == str(id):
			remove_child(Player)
			emit_signal("player_disconnected", id)


func _connected_ok():
	pass


func _connected_fail():
	pass


func _server_disconnected():
	get_tree().set_network_peer(null)
	connected = false
	
	# Must unregister all players if server disconnects
	for i in get_children():
		_player_disconnected(int(i.name))


# Attempt to start a server on default port with limited number of clients
func start_server(NetworkStatusNode, user_name, kirby_name):
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


func close_server(NetworkStatusNode):
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


func connect_to_ip(ip, NetworkStatusNode, user_name, kirby_name):
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


func disconnect_from_server(NetworkStatusNode):
	get_tree().set_network_peer(null)
	NetworkStatusNode.text = "Disconnected"
	
	# Must unregister all players if server stops hosting
	for i in get_children():
		_player_disconnected(int(i.name))


func send_msg(text):
	rpc("receive_msg", network_name, text)


remotesync func receive_msg(user, text):
	emit_signal("msg_received", user, text)
