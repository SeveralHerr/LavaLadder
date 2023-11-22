extends Node2D
class_name TileMapHandler

@export var bottom: Area2D
@export var camera: Camera2D
@export var playerObj: player

signal generated_chunk(position)


var tileScene: PackedScene = preload("res://tile_map_1.tscn")
var tileSceneNoLadder: PackedScene = preload("res://tile_map_2.tscn")
@onready var platform_handler = $"../PlatformHandler"


var chunkWidth = 112
var chunkHeight = 80
var chunkRows = []
var gravity = 0
	
func _physics_process(delta):
	var camera_size = get_viewport_rect().size / camera.zoom
	var chunksNeeded = ceil(camera_size.x / chunkWidth) + 3
	var rowsNeeded = ceil(camera_size.y / chunkHeight) + 1
	
	if chunkRows.size() <= rowsNeeded:
		GenerateRow(chunksNeeded)
		
	for chunkRow in chunkRows:
		for chunk in chunkRow:
			chunk.get_child(0).position.y += gravity * delta
		
		if chunkRow.size() <= chunksNeeded:
			AddChunkToRow(chunkRow)

		if chunkRow[0].get_child(0).position.y > 140:
			MoveRowToTop(chunkRow)
			
		if playerObj.position.x <= GetLeftMostChunk(chunkRow).get_child(0).position.x + chunkWidth*chunksNeeded:
			MoveRightChunkToLeftSide(chunkRow)
			
		if playerObj.position.x >= GetRightMostChunk(chunkRow).get_child(0).position.x - chunkWidth:
			MoveLeftChunkToRightSide(chunkRow)
			
	#camera.limit_left = chunkRows[0][0].get_child(0).position.x
	var chunkRow = chunkRows[0]
	#camera.limit_right = chunkRow[chunkRow.size() - 1].get_child(0).position.x
	
func GenerateRow(chunks):
	var currentChunkRow = []
	for i in chunks:		
		var chunk = AddChunk()
		var pos
		
		if chunkRows.size() <= 0:
			pos = Vector2(chunkWidth * i, 20)
		else:
			var lastRow = GetTopRow()[0].get_child(0)
			var newX = chunkWidth * i
			var newY = lastRow.position.y - chunkHeight

			pos = Vector2(newX, newY)
			
		print("This is my fault")
		var platform = platform_handler.create(Vector2(pos.x + chunkWidth/2, pos.y + chunkHeight/2))
		chunk.get_child(0).add_child(platform)
		#generated_chunk.emit(Vector2(pos.x + chunkWidth/2, pos.y + chunkHeight/2))
			
		chunk.get_child(0).position = pos
		currentChunkRow.append(chunk)
		
	chunkRows.append(currentChunkRow)

func MoveRowToTop(chunkRow):
	var topRow = GetTopRow()
	var lastRow = topRow[topRow.size() - 1]  # Get the last row from the result of GetTopRow()

	var newY = lastRow.get_child(0).position.y - chunkHeight

	for i in range(chunkRow.size()):
		var newX = chunkWidth * i
		var pos = Vector2(newX, newY)
		chunkRow[i].get_child(0).position = pos


func GetTopRow():
	var lowestY = 1000000
	var lowestChunk
	for chunkRow in chunkRows:
		var y = chunkRow[0].get_child(0).position.y
		if y <= lowestY:
			lowestY = y
			lowestChunk = chunkRow
			
	return lowestChunk
	
func AddChunkToRow(chunkRow):
	var chunk = AddChunk()
	var y = chunkRow[0].get_child(0).position.y
	var x = chunkRow[chunkRow.size() - 1].get_child(0).position.x + chunkWidth
		
	chunk.get_child(0).position = Vector2(x, y)
	chunkRow.append(chunk)

func AddChunk():
	randomize()  # Seed the random number generator
	var random_number = round(randf_range(1, 2))  # Get a random number between 1 and 2
	var instance
	
	if random_number == 1:
		instance = tileScene.instantiate()
	else:
		instance = tileSceneNoLadder.instantiate()
	
	add_child(instance)
	add_to_group("Tiles")

	return instance
	
func GetLeftMostChunk(chunkRow):
	var leftestX = 10000000000000
	var leftestChunk
	for chunk in chunkRow:
		var x = chunk.get_child(0).position.x
		if x <= leftestX:
			leftestX = x
			leftestChunk = chunk
	return leftestChunk
	
func GetRightMostChunk(chunkRow):
	var rightX = -10000000000000
	var rightChunk
	for chunk in chunkRow:
		var x = chunk.get_child(0).position.x
		if x >= rightX:
			rightX = x
			rightChunk = chunk
	return rightChunk

func MoveRightChunkToLeftSide(chunkRow):
	var rightChunk = GetRightMostChunk(chunkRow)
	var leftChunk = GetLeftMostChunk(chunkRow)
	rightChunk.get_child(0).position.x = leftChunk.get_child(0).position.x - chunkWidth

func MoveLeftChunkToRightSide(chunkRow):
	var rightChunk = GetRightMostChunk(chunkRow)
	var leftChunk = GetLeftMostChunk(chunkRow)
	leftChunk.get_child(0).position.x = rightChunk.get_child(0).position.x + chunkWidth
	
func _on_gravity_timer_timeout():
	print(gravity)
	#gravity = ceil(gravity * 1.1)
	gravity = ceil(gravity * 1.005)
