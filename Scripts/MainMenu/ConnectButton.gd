extends Button

func _ready():
	var _err = connect("pressed", self, "_on_pressed")


func _on_pressed():
	var par = get_parent()
	if Server.connected:
		Server.disconnect_from_server(par.get_node("ServerStatusLabel"))
		Server.connected = false
		
		# Reenable hosting and connecting abilities after disconnecting
		text = "Connect"
		rect_size.x = 48
		par.get_node("IPAddressEntry").editable = true
		
		par.get_node("PortForwardingCheckBox").disabled = false
		par.get_node("PortForwardingCheckBox").visible = true
		
		par.get_node("HostButton").disabled = false
		par.get_node("HostButton").visible = true
	else:
		var status = Server.connect_to_ip(par.get_node("IPAddressEntry").text, par.get_node("ServerStatusLabel"),\
				par.get_node("UserNameEntry").text, par.get_node("KirbyNameEntry").text)
		
		if (status == 0):
			Server.connected = true
			
			# Disable hosting and connecting abilities on a successful connection
			text = "Disconnect"
			par.get_node("IPAddressEntry").editable = false
			
			par.get_node("PortForwardingCheckBox").disabled = true
			par.get_node("PortForwardingCheckBox").visible = false
			
			par.get_node("HostButton").disabled = true
			par.get_node("HostButton").visible = false
