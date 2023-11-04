extends Node2D

@export var tilemap1: TileMap
var tileScene: PackedScene = preload("res://tile_map.tscn")

func _ready():
	var instance = tileScene.instantiate()
	add_child(instance)
