extends Node


var users : Dictionary = {}

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")


func _player_connected(id):
	print("player connected")
	Chat.send("[NETWORK] Player %s just connected." % id)

func _player_disconnected(id):
	print("player disconnected")
	Chat.send("[NETWORK] Player %s just disconnected." % id)
	users.erase(id) # Erase player from info.

func _connected_ok():
	print("connected ok")
	Chat.send("[NETWORK] You just connected.")
	# Only called on clients, not server. Will go unused; not useful here.

func _server_disconnected():
	print("server disconnected")
	Chat.send("[NETWORK] You just disconnected.")
	pass # Server kicked us; show error and abort.

func _connected_fail():
	print("connected fail")
	Chat.send("[NETWORK] Connection failed.")
	pass # Could not even connect to server; abort.

remote func register_player(info:Dictionary):
	print("Register player")
	Chat.send("[NETWORK] Registering new player with info: %d" % info)
	# Get the id of the RPC sender.
	var id = get_tree().get_rpc_sender_id()
	# Store the info
	users[id] = info

	# Call function to update lobby UI here

func get_user(username:String):
	for user in users:
		if user.username == username:
			return user
	
	print("User not found.")
	return null
	

func create_server(port=4000, max_players=4):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(port, max_players)
	get_tree().network_peer = peer
	Chat.send("[NETWORK] Created a server on port 4000.")
	return peer


func create_client(ip="127.0.0.1", port=4000):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, port)
	get_tree().network_peer = peer
	Chat.send("[NETWORK] Connected as a client in 127.0.0.1:4000")
	return peer

func terminate():
	get_tree().network_peer = null
	Chat.send("[NETWORK] Networking terminated.")
