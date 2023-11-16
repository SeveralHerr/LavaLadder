extends CharacterBody2D

class_name player

enum PlayerState {
	OnLadder,
	Walking
}
@export var camera : Camera2D
@export var speed = 200 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump = -200;
var on_ladder = false
var climb_speed = -66
var state : PlayerState = PlayerState.Walking
@export var lava: Lava

func set_state(new_state: PlayerState):
	state = new_state


func _burned():
	if position.y >= 150:
		get_tree().change_scene_to_file("res://GameOver.tscn")
	

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	add_to_group("Player")
	lava.burnedByLava.connect(_burned)

	
func _physics_process(delta):
	_burned()
	camera.position.x = global_position.x
	
	#var velocity = Vector2()
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else: 
		velocity.x = move_toward(velocity.x, 0, speed)
			
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump
	if state == PlayerState.OnLadder:
		gravity = 0
		if Input.is_action_pressed("move_up"):
			velocity.y = climb_speed
			print(velocity.y)
		else:
			velocity.y = 0;
	else:
		gravity = 500
		velocity.y += gravity * delta
		
	#velocity.y += gravity * delta
	move_and_slide()

func _on_ladder_area_entered(area):
	on_ladder = true

func _on_ladder_area_exited(area):
	on_ladder = false




func start(pos):
	position = pos
	$CollisionShape2D.disabled = false



func _on_ladder_body_entered(body):
	on_ladder = true



func _on_ladder_body_exited(body):
	on_ladder = false



func _on_area_2d_body_entered(body):
	print("Collision Detected with: ", body.name)
	if  body is player:
		get_tree().change_scene_to_file("res://GameOver.tscn")


func _on_area_2d_area_entered(area):
	print("Collision Detected with: ", area.name)
	get_tree().change_scene_to_file("res://Gameover.tscn")
