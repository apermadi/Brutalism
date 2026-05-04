## File: Camera_Script.gd
## Brief: First person camera movement attached to the player.

extends Camera3D

# const variables
const SENSITIVITY := 0.001

# variables
var rot_x := 0.0
var rot_y := 0.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# majority of the code is provided in the docs about transformations in 3D space
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rot_x +=  event.relative.x * SENSITIVITY * -1
		rot_y += event.relative.y * SENSITIVITY * -1
		rot_y = clampf(rot_y, deg_to_rad(-60), deg_to_rad(60))
		# reset basis before applying rotations 
		transform.basis = Basis()
		rotate_object_local(Vector3.UP, rot_x)
		rotate_object_local(Vector3.RIGHT, rot_y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	transform.orthonormalized()
