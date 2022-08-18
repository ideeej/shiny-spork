extends Resource
class_name PopupTweener

enum EaseType {
	EASE_IN,
	EASE_OUT,
	EASE_IN_OUT,
	EASE_OUT_IN
}

enum TransitionType {
	TRANS_LINEAR,
	TRANS_SINE,
	TRANS_QUINT,
	TRANS_QUART,
	TRANS_QUAD,
	TRANS_EXPO,
	TRANS_ELASTIC,
	TRANS_CUBIC,
	TRANS_CIRC,
	TRANS_BOUNCE,
	TRANS_BACK
}

enum PopupDirection {
	TOP,
	RIGHT,
	BOTTOM,
	LEFT
}

export(EaseType) var ease_type
export(TransitionType) var transition_type
export(PopupDirection) var popup_direction
export(int) var popup_duration := 1
export(int) var hide_duration := 1
export(bool) var remove_on_hide := false



