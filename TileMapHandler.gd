extends Node2D

@export var tilemap1: TileMap
@export var bottom: Area2D
var tileScene: PackedScene = preload("res://tile_map_1.tscn")
var tileSceneNoLadder: PackedScene = preload("res://tile_map_2.tscn")
var tileRow = []
var tileRow2 = []
var tileRow3 = []
var tileRowArray = []
var columns = 8
var columnSize = 112

func _ready():
	_create_row()
	
func _create_row():
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
		child.position.y = -60
		child.position.x = (columnSize * i)
		tileRow.append(instance)
		add_to_group("Tiles")
		
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
		child.position.y = 20
		child.position.x = (columnSize * i)
		tileRow2.append(instance)
		add_to_group("Tiles")
		
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
		child.position.y = -140
		child.position.x = (columnSize * i)
		tileRow3.append(instance)
		add_to_group("Tiles")
	
		tileRowArray.append(tileRow)
		tileRowArray.append(tileRow2)
		tileRowArray.append(tileRow3)
	
func _physics_process(delta):
	for tileRow in tileRowArray:
		if tileRow[0].get_child(0).position.y > 140:
			tileRow.shuffle()
			for index in range(tileRow.size()):
				var tile = tileRow[index]
				var child = tile.get_child(0)
				child.position.y = -100
				child.position.x = index * columnSize

	
func d_process(delta):
	if tileRow[0].get_child(0).position.y > 140:
		tileRow.shuffle()
		for index in range(tileRow.size()):
			var tile = tileRow[index]
			var child = tile.get_child(0)
			child.position.y = -100
			child.position.x = index * columnSize
	if tileRow2[0].get_child(0).position.y > 140:
		tileRow2.shuffle()
		for index in range(tileRow2.size()):
			var tile = tileRow2[index]
			var child = tile.get_child(0)
			child.position.y = -100
			child.position.x = index * columnSize
	if tileRow3[0].get_child(0).position.y > 140:
		tileRow3.shuffle()
		for index in range(tileRow3.size()):
			var tile = tileRow3[index]
			var child = tile.get_child(0)
			child.position.y = -100
			child.position.x = index * columnSize


