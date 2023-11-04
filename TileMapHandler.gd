extends Node2D

@export var tilemap1: TileMap
var tileScene: PackedScene = preload("res://tile_map_1.tscn")
var tileSceneNoLadder: PackedScene = preload("res://tile_map_2.tscn")
var tileRow = []
var columns = 8
var columnSize = 112

func _ready():
	for i in range(columns):
		randomize()  # Seed the random number generator
		var random_number = round(randf_range(1, 2))  # Get a random number between 1 and 2
		var instance
		
		if random_number == 1:
			instance = tileScene.instantiate()
		else:
			instance = tileSceneNoLadder.instantiate()
		
		add_child(instance)
		var child = instance.get_child(0)
		child.position.y = 200
		child.position.x = (columnSize * i)
		tileRow.append(instance)
		add_to_group("Tiles")
	
	
func _process(delta):

	if tileRow[0].get_child(0).position.y > 350:
		for tile in tileRow:
			var child = tile.get_child(0)
			child.position.y = 200


func _on_shrink_timer_timeout():
	var tiles = get_tree().get_nodes_in_group("Tiles")[1]
	tiles.scale = tiles.scale * 0.999
