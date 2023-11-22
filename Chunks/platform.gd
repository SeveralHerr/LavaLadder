extends Node2D
class_name Platform
var gravity = 0

var platform = preload("res://Chunks/platform.tscn")
@export var tile_map_handler: TileMapHandler
var instance: Node2D

@export var timer:Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", Callable(self, '_on_gravity_timer_timeout'))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):

	position.y += gravity * delta
		
func generate_platform():
	instance = platform.instantiate()

	pass

func _on_gravity_timer_timeout():
	print(gravity)
	#gravity = ceil(gravity * 1.1)
	gravity = ceil(gravity * 1.005)
