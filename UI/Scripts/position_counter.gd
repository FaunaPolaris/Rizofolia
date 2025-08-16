extends TextureRect

func	_process(delta: float) -> void:
	$X.text = str(Global.current_mouse_hover_tile.x)
	$Y.text = str(Global.current_mouse_hover_tile.y)
