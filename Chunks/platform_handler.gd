extends Node
var gravity = 10

var platform_instance
var platform_scene = preload("res://Chunks/platform.tscn")
@export var tile_map_handler: TileMapHandler


# Called when the node enters the scene tree for the first time.
func _ready():
	tile_map_handler.connect("generated_chunk", Callable(self, 'generate_platform'))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func _physics_process(delta):
	# platform.position.y += gravity * delta
	pass
		
var rng = RandomNumberGenerator.new()


func generate_platform(position):
	print("attempting to generate platform")
	platform_instance = platform_scene.instantiate()
	var random_x = rng.randf_range(-10.0, 10.0)
	var random_y = rng.randf_range(-10.0, 10.0)
	platform_instance.position.y = position.y - random_y
	platform_instance.position.x = position.x - random_x
	add_child(platform_instance)
	print("platform position: " + str(platform_instance.position))
	pass
