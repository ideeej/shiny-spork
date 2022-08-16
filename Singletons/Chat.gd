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
		send("[NETWORK] %s Default. Serving on 127.0.0.1:4000..." % NetworkManager.me.id)
		return
	
	if command == "NETWORK":
		NetworkManager.create_client()
		send("[NETWORK] Default. Connecting to 127.0.0.1:4000")
		return
	send("[CHAT] Comando não encontrado.")
	
	
	
	
	

