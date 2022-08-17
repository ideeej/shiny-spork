extends Control

onready var RegisterPopup : PopupPanel = $RegisterPopup/Popup
onready var LoginPopup : PopupPanel = $LoginPopup/Popup

onready var email_edit = $RegisterPopup/Popup/VBoxContainer/MainMargin/VBoxContainer2/EmailField/LineEdit
onready var password_edit = $RegisterPopup/Popup/VBoxContainer/MainMargin/VBoxContainer2/PasswordField/LineEdit
onready var password_confirm = $RegisterPopup/Popup/VBoxContainer/MainMargin/VBoxContainer2/PasswordField2/LineEdit

onready var login_email = $LoginPopup/Popup/VBoxContainer/MainMargin/VBoxContainer2/EmailField/LineEdit
onready var login_password = $LoginPopup/Popup/VBoxContainer/MainMargin/VBoxContainer2/PasswordField/LineEdit

onready var user_name = $OuterMargin/MainMargin/Wrapper/LineEdit


func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")

func _on_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body : Dictionary = JSON.parse(body.get_string_from_ascii()).result as Dictionary
	print({"response_body": response_body})
	
	if response_code == 200:
		RegisterPopup.hide()
		LoginPopup.hide()
		user_name.text = "FUNCIONOU!"


func _on_REGISTER_pressed():
	RegisterPopup.popup_centered()
	

func _on_LOGIN_pressed():
	LoginPopup.popup_centered()



func _on_login_closed():
	LoginPopup.hide()


func _on_register_closed():
	RegisterPopup.hide()


func _on_LoginButton_pressed():
	Firebase.login(login_email.text, login_password.text, $HTTPRequest)


func _on_RegisterButton_pressed():
	if password_edit.text == password_confirm.text:
		Firebase.register(email_edit.text, password_edit.text, $HTTPRequest)
