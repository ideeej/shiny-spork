extends LineEdit


onready var MessagesContainer = $"../../ChatScroll/Chat"

func _ready():
	connect("text_entered", self, "_on_text_entered")

func _on_text_entered(new_text:String):
	Chat.send(new_text)
	self.text = ""

	



