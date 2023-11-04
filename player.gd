extends CharacterBody2D

class_name player

enum PlayerState {
	OnLadder,
	Walking
}
@export var speed = 200 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump = -2300;
var on_ladder = false
var climb_speed = 90
var state : PlayerState = PlayerState.Walking

func f_process(delta):
	match state:
		PlayerState.OnLadder:
			state = PlayerState.OnLadder
		PlayerState.Walking:
			state = PlayerState.Walking

func set_state(new_state: PlayerState):
	state = new_state


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func f_physics_process(delta):
	if on_ladder || state == PlayerState.OnLadder:
		velocity.y = -climb_speed
		position.y -= 1
	else:
		if not is_on_floor() and not state == PlayerState.OnLadder:
			velocity.y += gravity + delta
		else:
			velocity.y = 0
			
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump
			


	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else: 
		velocity.x = move_toward(velocity.x, 0, speed)
			
	move_and_slide()
	
func ff_physics_process(delta):
	print(gravity)
	if state != PlayerState.OnLadder:
		velocity.y += gravity
	elif state == PlayerState.OnLadder:
		velocity.y = -climb_speed
		gravity = 0
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump


	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else: 
		velocity.x = move_toward(velocity.x, 0, speed)
			
	move_and_slide()
	
func _physics_process(delta):
	#var velocity = Vector2()
	print(gravity)
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else: 
		velocity.x = move_toward(velocity.x, 0, speed)
			
	if state == PlayerState.OnLadder:
		gravity = 0
		if Input.is_action_just_pressed("move_up"):
			velocity.y -= climb_speed
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

func dphysics_process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		

	velocity = velocity.normalized() * speed
	self.linear_velocity.x = velocity.x # Only modify the horizontal component

	# Clamping position should be done separately if needed
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func t_process(delta):
	# Apply gravity in _process
	self.linear_velocity.y += gravity * delta




func start(pos):
	position = pos
	$CollisionShape2D.disabled = false



func _on_ladder_body_entered(body):
	on_ladder = true


func _on_ladder_body_exited(body):
	on_ladder = false
