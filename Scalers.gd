extends Node2D

@export var camera: Camera2D
var originalYPos
var gravity = 10
var velocity = Vector2.DOWN
@onready var playerObj = get_tree().get_nodes_in_group("Player")[1]


# Called when the node enters the scene tree for the first time.
func _ready():
	originalYPos = 40


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var scaleFactor = 0.9999
	camera.zoom *= scaleFactor
	#camera.limit_top = -199
	camera.limit_bottom = 155

 
