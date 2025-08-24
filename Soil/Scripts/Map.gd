extends Node2D


@export var highlight_texture: Texture2D
var highlight_sprite: Sprite2D

var	pop_up	= preload("res://UI/Scenes/tileInspecPopUp.tscn")
var map_size	: int = 16
var	tiles		: Array[Tile]

func	_ready():
	initTiles(map_size)
	updateDisplayedTiles(tiles)
	initHighlight()
	Global.tiles = tiles
	
func	initTiles(size):
	var offset = size *  .5
	var coord : Vector2 = Vector2(-offset, -offset)
	
	while coord.y < offset:
		coord.x = -offset
		while coord.x < offset:
			var new_tile = Tile.new(Vector2i(coord.x, coord.y), randi_range(0, 2), randi_range(0, 3),
				randi_range(0, 4), randi_range(0, 2), randi_range(0, 2))
			tiles.append(new_tile)
			coord.x += 1
		coord.y += 1 

	
func updateDisplayedTiles(input : Array[Tile]):
	for tile in tiles:
		$"textures/soil".set_cell(tile.coords, 0, Vector2i(tile.soil_quality, 0))
		$textures/leaf.set_cell(tile.coords, 0, Vector2i(tile.leaf_coverage, 0))
		$textures/canopy.set_cell(tile.coords, 0, Vector2i(tile.canopy_tree, 0))
		$"textures/under-story".set_cell(tile.coords, 0, Vector2i(tile.under_story, 1))
		$"textures/forest-ground".set_cell(tile.coords, 0, Vector2i(tile.forest_ground, 2))

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if get_viewport().gui_get_hovered_control() != null:
			return
		if event.get_button_index() == MOUSE_BUTTON_LEFT:
			var mouse_pos = get_global_mouse_position()
			var tile_pos = $textures/soil.local_to_map(to_local(mouse_pos))
			Global.selected_tile = tile_pos
			openSpecWindow(tile_pos)

func	openSpecWindow(tile : Vector2):
	var new_window = pop_up.instantiate()
	print(tile)
	add_child(new_window)
	new_window.initialize(tiles[((tile.y + 8) * map_size) + (tile.x + 8)])

func initHighlight():
	highlight_sprite = Sprite2D.new()
	highlight_sprite.texture = highlight_texture
	highlight_sprite.z_index = 1
	add_child(highlight_sprite)
	highlight_sprite.hide()

func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	var tile_pos = $textures/soil.local_to_map(to_local(mouse_pos))
	
	if $textures/soil.get_cell_source_id(tile_pos) != -1:
		highlight_sprite.position = $textures/soil.map_to_local(tile_pos)
		Global.current_mouse_hover_tile = tile_pos
		highlight_sprite.show()
	else:
		highlight_sprite.hide()
