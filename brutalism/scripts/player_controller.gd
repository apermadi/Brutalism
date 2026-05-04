## File: Player_Script.gd
## Brief: contains basic movement necessary for the player

extends CharacterBody3D

# variables
@export var speed := 10
@export var jump_impulse := 20
@export var fall_acceleration := 75

# variables
@onready var player_camera := $Marker3D/Camera

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# changes direction the player is facing according to the camera's angle
	direction = direction.rotated(Vector3.UP, player_camera.rotation.y)
	
	if (is_on_floor() and Input.is_action_just_pressed("jump")):
		velocity.y = jump_impulse
	
	if (!is_on_floor()):
		velocity.y = velocity.y - (fall_acceleration * delta)
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
