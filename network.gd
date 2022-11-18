extends Node

const DEFAULT_PORT = 28960
const MAX_CLIENTS = 6

var server = null
var client = null

var ip_address = "127.0.0.1"

func _ready():
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	
func create_server():
	print("Creating Server . .")
	
	server = NetworkedMultiplayerENet.new()
	server.create_server(DEFAULT_PORT, MAX_CLIENTS)
	get_tree().set_network_peer(server)
	
func join_server():
	print("Joining Server . .")
	
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip_address, DEFAULT_PORT)
	get_tree().set_network_peer(client)

func _connected_ok():
	print("Successfully connected to server")

func _connected_fail():
	print("Connection to server failed")

func _server_disconnected():
	print("Disconnected from the server")
	reset_network_connection()

func _player_connected(id):
	print("Player: " + str(id) + " connected :D ")
	
func _player_disconnected(id):
	print("Player: " + str(id) + " disconnected D: ")

func reset_network_connection():
	if get_tree().has_network_peer():
		get_tree().network_peer = null
	
