extends TileMap

@export var playerObj: player

var gravity = 10 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	position.y += gravity * delta
	var tile_coords := local_to_map(to_local(playerObj.global_position))
	var layer := 1
	
	var tile_data = get_cell_tile_data(layer, tile_coords)
	
	if tile_data and tile_data.get_custom_data("Ladder"):
		playerObj.set_state(playerObj.PlayerState.OnLadder)
		# Your ladder climbing code here
	else:
		playerObj.set_state(playerObj.PlayerState.Walking)
			
		# Your other movement code here
