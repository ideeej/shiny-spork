extends Panel


func _ready():
	pass

func _process(_event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		showup_tween()
	

func showup_tween():
	var TW := create_tween()
	TW.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	TW.tween_property(self, "rect_position", Vector2(0, 600), 2)
	TW.tween_property(self, "rect_position", Vector2(0, 0), 2)
	yield(TW, "finished")

