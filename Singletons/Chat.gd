extends Node

var Log: Array = []
var commands: Array = [
	"help",
	"clear",
	"serve",
	"network",
	"send"
]

signal on_chat_message(msg)
signal on_chat_clear

func send(text:String):
	var message : Dictionary = {
		"text": text
	}
	
	Log.append(message)
	emit_signal("on_chat_message", message)
	
	if text.begins_with("/"):
		#this is a command and should be run!
		_run(message)


func _run(message:Dictionary):
	print("Trying to run...")
	
	var instructions : Array = message.text.split(" ")
	var command : String = instructions[0].trim_prefix("/").to_upper()
	
	print(instructions)
	if command == "HELP":
		send("[HELP] Se vira. Assinado pelo dev c:")
		return
	if command == "CLEAR":
		Log.clear()
		emit_signal("on_chat_clear")
		send("[CHAT] Chat limpo.")
		return
	if command == "SERVE":
		NetworkManager.create_server()
		send("[NETWORK] Serving...")
		return
	if command == "NETWORK":
		NetworkManager.create_client()
		send("[NETWORK] Connecting...")
		return
	if command == "SEND":
		#NetworkManager.send(instructions.slice(1, instructions.size()-1))
		var m : Array = instructions.slice(1, instructions.size()-1)
		var send_msg = "" 
		for word in m:
			send_msg += str(word) + " "
		send(send_msg)
		return
	
	send("[CHAT] Comando não encontrado.")
	
	
	
	
	

