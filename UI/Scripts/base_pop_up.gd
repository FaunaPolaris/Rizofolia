extends Control

class_name	PopUp

var pop_up_inspect_scene	= load("res://UI/Scenes/inspecPopUp.tscn")

var	have_mouse	: bool = false
var	tile_pos
var	tile
var drag_offset := Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and have_mouse:
		handleZIndex()
		if event.button_index == MOUSE_BUTTON_LEFT:
			drag_offset = get_global_mouse_position() - global_position
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			queue_free()
	elif event is InputEventMouseButton and not event.pressed:
		drag_offset = Vector2.ZERO

func _process(delta: float) -> void:
	if drag_offset != Vector2.ZERO:
		global_position = get_global_mouse_position() - drag_offset

func	initialize(_tile : Tile) -> void:
	tile = _tile
	tile_pos = _tile.coords
	handleZIndex()
	position.x = tile_pos.x * 16 + randi_range(8, 16)
	position.y = tile_pos.y * 16 + randi_range(8, 16)
	$vbox/hbox/title.text = str("(", int(tile_pos.x), ", ", int(tile_pos.y), ")")
	$"vbox/basic info".initialize(_tile)

func	initialize2(_tile : Tile) -> void:
	tile = _tile
	tile_pos = _tile.coords
	handleZIndex()
	$MarginContainer/list.initialize(tile)
	$vbox/hbox/title.text = str("(", int(tile_pos.x), ", ", int(tile_pos.y), ")")

func	handleZIndex():
	var max_z = 0
	for sibling in get_parent().get_children():
		if sibling != self and sibling.z_index > max_z and sibling.z_index != 4096:
			max_z = sibling.z_index
		z_index = max_z + 1

func _on_close_pressed() -> void:
	queue_free()

func _on_control_mouse_entered() -> void:
	have_mouse = true
	print("mouse is mine")

func _on_control_mouse_exited() -> void:
	have_mouse = false
	print("no mouse here :(")

func _on_inspect_pressed() -> void:
	var new_window =  pop_up_inspect_scene.instantiate()
	add_sibling(new_window)
	new_window.initialize2(tile)
	new_window.position.y = position.y
	new_window.position.x = position.x + 48
	
