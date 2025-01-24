extends Node

var network = ENetMultiplayerPeer.new()
const ip = "127.0.0.1"
const port = 1909
var connected = false

func _ready():
	ConnectToServer()

func ConnectToServer():
	network.create_client(ip, port)
	multiplayer.multiplayer_peer = network
	
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)
		
		
func _on_connected_ok():
	connected = true
	print("Succesfully connected")
	
func _on_connected_fail():
	print("Failed to connect")
	
func server_connected():
	return connected

	

func FetchPlayerStats(player_stats, requester):
	if(connected):
		rpc_id(1,"FetchPlayerStatss", player_stats, requester)
	
@rpc("any_peer", "call_remote", "reliable")
func ReturnPlayerStats(stats, requester):
	instance_from_id(requester).Set_Speed(stats["Speed"])

@rpc("any_peer", "reliable")
func _register_player(new_player_info):
	pass
	
@rpc("any_peer", "reliable")
func FetchPlayerStatss(player_stats, requester):
	pass
