extends Control


func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")

func _on_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body : Dictionary = JSON.parse(body.get_string_from_ascii()).result as Dictionary
	
	if response_code != 200:
		$RichTextLabel.text = response_body.error.message.capitalize()
	else:
		$RichTextLabel.text = "Deu boa"
		
	print("Request completed")
	print({"response_body": response_body})


func _on_REGISTER_pressed():
	Firebase.register("email@test.com", "mypasstword5", $HTTPRequest)

func _on_LOGIN_pressed():
	Firebase.login("email@test.com", "mypasstword5", $HTTPRequest)
