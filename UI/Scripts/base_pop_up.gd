extends Control

var	have_mouse	: bool = false

var drag_offset := Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and have_mouse:
		if event.button_index == MOUSE_BUTTON_LEFT:
			drag_offset = get_global_mouse_position() - global_position
	elif event is InputEventMouseButton and not event.pressed:
		drag_offset = Vector2.ZERO

func _process(delta: float) -> void:
	if drag_offset != Vector2.ZERO:
		global_position = get_global_mouse_position() - drag_offset

func	initialize(tile_pos : Vector2) -> void:
	position.x = tile_pos.x * 16
	position.y = tile_pos.y * 16
	$title.text = str("tile: (", tile_pos.x, ", ", tile_pos.y, ")")

func _on_close_pressed() -> void:
	queue_free()

func _on_control_mouse_entered() -> void:
	have_mouse = true
	print("mouse on me")

func _on_control_mouse_exited() -> void:
	have_mouse = false
	print("mouse left me")
