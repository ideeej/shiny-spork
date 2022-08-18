extends VBoxContainer


func _ready():
	Chat.connect("on_chat_message", self, "_on_chat_message")
	Chat.connect("on_chat_clear", self, "_on_chat_clear")
	

func create_new_message(msg:Dictionary):
	var new_msg = RichTextLabel.new()
	new_msg.fit_content_height = true
	new_msg.bbcode_enabled = true
	new_msg.selection_enabled = true
	new_msg.bbcode_text = msg.text
	return new_msg

func _on_chat_message(msg:Dictionary):
	add_child(create_new_message(msg))
	

func _on_chat_clear():
	for child in get_children():
		child.queue_free()
	print("Cleared!")
