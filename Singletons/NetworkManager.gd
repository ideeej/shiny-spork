extends Node


var users : Dictionary = {}
var me : Dictionary = {}

func _ready():
	get_tree().connect("network_peer_connected", self, "_peer_connected")
	get_tree().connect("network_peer_disconnected", self, "_peer_disconnected")
	
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")


# NETWORK UTILITIES0

func create_server(port=4000, max_players=4):
	var peer : NetworkedMultiplayerENet = NetworkedMultiplayerENet.new()
	peer.create_server(port, max_players)
	get_tree().network_peer = peer
	
	me[peer.id] = me
	
	Chat.send("[NETWORK] %s Created a server on port 4000." % me.id)
	return peer

func create_client(ip="127.0.0.1", port=4000):
	var peer : NetworkedMultiplayerENet = NetworkedMultiplayerENet.new()
	peer.create_client(ip, port)
	get_tree().network_peer = peer
	
	me.peer = peer
	me.id = peer.get_unique_id()
	
	Chat.send("[NETWORK] %s Connected as a client in 127.0.0.1:4000" % me.id)
	return peer

func send(message:Dictionary):
	pass

func terminate():
	get_tree().network_peer = null
	Chat.send("[NETWORK] Networking terminated.")


# SERVER SIGNALS
func _peer_connected(id):
	Chat.send("[NETWORK] Player %s just connected." % id)

func _peer_disconnected(id):
	Chat.send("[NETWORK] Player %s just disconnected." % id)
	users.erase(id) # Erase player from info.


# CLIENT SIGNALS
func _connected_ok():
	Chat.send("[NETWORK] You just connected.")
	# Only called on clients, not server. Will go unused; not useful here.

func _server_disconnected():
	Chat.send("[NETWORK] You just disconnected.")
	pass # Server kicked us; show error and abort.

func _connected_fail():
	Chat.send("[NETWORK] Connection failed.")
	pass # Could not even connect to server; abort.


# RPC FUNCTIONS
remote func register_player(info:Dictionary):
	Chat.send("[NETWORK] Registering new player with info: %d" % info)
	# Get the id of the RPC sender.
	var id = get_tree().get_rpc_sender_id()
	# Store the info
	users[id] = info

	# Call function to update lobby UI here


