extends Control

func	initialize(tile_pos : Vector2) -> void:
	position.x = tile_pos.x * 16
	position.y = tile_pos.y * 16
	$title.text = str("tile: (", tile_pos.x, ", ", tile_pos.y, ")")

func _on_close_pressed() -> void:
	queue_free()
