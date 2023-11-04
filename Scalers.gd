extends Node2D

@export var tiles: RigidBody2D
var originalYPos
var gravity = 10
var velocity = Vector2.DOWN

# Called when the node enters the scene tree for the first time.
func _ready():
	originalYPos = 40


# Called every frame. 'delta' is the elapsed time since the previous frame.
func k_process(delta):
	var scaleFactor = 0.9995
	tiles.scale *= scaleFactor

