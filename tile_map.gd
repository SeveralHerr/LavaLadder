extends TileMap

@onready var playerObj = get_tree().get_nodes_in_group("Player")[1]
var wasInBounds = false;


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
	var layer := 0

	# Get the used rectangle of the TileMap
	var used_rect = get_used_rect()

	# Check if the tile coordinates are within the bounds of the used rectangle
	if tile_coords.x < used_rect.position.x or tile_coords.y < used_rect.position.y or tile_coords.x >= used_rect.end.x or tile_coords.y >= used_rect.end.y:
		if wasInBounds == true:
			playerObj.set_state(playerObj.PlayerState.Walking)        
			wasInBounds = false
		
		return

	wasInBounds = true
	var tile_data = get_cell_tile_data(layer, tile_coords)

	
	if tile_data and tile_data.get_custom_data("Ladder"):
		playerObj.set_state(playerObj.PlayerState.OnLadder)
		playerObj.collision_mask = 4
		# Your ladder climbing code here
	else:
		playerObj.set_state(playerObj.PlayerState.Walking)  
		playerObj.collision_mask = 1
		# Your other movement code here
