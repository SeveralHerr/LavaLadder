extends Node2D
var gravity = 10

var platform = preload("res://Chunks/platform.tscn")
@export var tile_map_handler: TileMapHandler


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tile_map_handler.connect("generate_chunk", self, "generate_platform")
	pass

func _physics_process(delta):

	position.y += gravity * delta
		
func generate_platform():
	
	pass
