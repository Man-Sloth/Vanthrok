extends Node

var network = ENetMultiplayerPeer.new()
const ip = "127.0.0.1"
const port = 1909

func _ready():
	ConnectToServer()

func ConnectToServer():
	network.create_client(ip, port)
	multiplayer.multiplayer_peer = network
	
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)
		
		
func _on_connected_ok():
	print("Succesfully connected")
	#var peer_id = multiplayer.get_unique_id()
	#players[peer_id] = player_info
	#player_connected.emit(peer_id, player_info)
	
func _on_connected_fail():
	print("Failed to connect")
	#players.erase(id)
	#player_disconnected.emit(id)

@rpc("any_peer", "reliable")
func _register_player(new_player_info):
	pass
