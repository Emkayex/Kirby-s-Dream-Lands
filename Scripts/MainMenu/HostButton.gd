extends Button

func _ready():
	var _err = connect("pressed", self, "_on_pressed")


func _on_pressed():
	if Server.connected:
		Server.close_server(get_parent().get_node("ServerStatusLabel"))
		Server.connected = false
		
		# Reenable ability to start a server
		var port_forward_check_box = get_parent().get_node("PortForwardingCheckBox")
		port_forward_check_box.disabled = false
		port_forward_check_box.visible = true
		text = "Host"
		rect_size.x = 33
		
		# Reenable options to connect to a server
		var ip_field = get_parent().get_node("IPAddressEntry")
		ip_field.editable = true
		ip_field.visible = true
		
		var connect_button = get_parent().get_node("ConnectButton")
		connect_button.disabled = false
		connect_button.visible = true
	
	else:
		var status = Server.start_server(get_parent().get_node("ServerStatusLabel"),\
				get_parent().get_node("UserNameEntry").text, get_parent().get_node("KirbyNameEntry").text)
		
		if status == 0:
			Server.connected = true
			
			# Disable ability to start a server
			var port_forward_check_box = get_parent().get_node("PortForwardingCheckBox")
			port_forward_check_box.disabled = true
			port_forward_check_box.visible = false
			text = "Close Server"
			
			# Disable options to connect to a server
			var ip_field = get_parent().get_node("IPAddressEntry")
			ip_field.editable = false
			ip_field.visible = false
			
			var connect_button = get_parent().get_node("ConnectButton")
			connect_button.disabled = true
			connect_button.visible = false
