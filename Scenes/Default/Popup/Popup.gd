extends Control


onready var panel = $Control/Panel

var is_tweening := false
var popup_speed := 1.2
var hide_speed := 1

signal on_popped
signal on_hid

func _ready():
	pass

func _process(_event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		tween_popup()
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		tween_hide()
	


func tween_popup():
	if is_tweening:
		return
	is_tweening = true
	
	var TW := create_tween()
	TW.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	TW.tween_property(panel, "rect_position", Vector2(0, 0), popup_speed)

	
	yield(TW, "finished")
	is_tweening = false
	emit_signal("on_popped")


func tween_hide():
	if is_tweening:
		return
	is_tweening = true
	
	var TW := create_tween()
	TW.set_trans(Tween.TRANS_EXPO)
	TW.tween_property(panel, "rect_position", Vector2(0, OS.get_screen_size().y), hide_speed)
	
	yield(TW, "finished")
	is_tweening = false
	emit_signal("on_hid")


