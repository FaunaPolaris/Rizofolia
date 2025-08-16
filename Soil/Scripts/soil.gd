extends TileMapLayer

@export var highlight_texture: Texture2D
var highlight_sprite: Sprite2D

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = get_global_mouse_position()
		var tile_pos = local_to_map(to_local(mouse_pos))
		Global.selected_tile = tile_pos

func _ready():
	highlight_sprite = Sprite2D.new()
	highlight_sprite.texture = highlight_texture
	highlight_sprite.z_index = 1
	add_child(highlight_sprite)
	highlight_sprite.hide()

func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	var tile_pos = local_to_map(to_local(mouse_pos))
	
	if get_cell_source_id(tile_pos) != -1:
		highlight_sprite.position = map_to_local(tile_pos)
		Global.current_mouse_hover_tile = tile_pos
		highlight_sprite.show()
	else:
		highlight_sprite.hide()
