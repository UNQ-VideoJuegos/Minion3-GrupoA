extends KinematicBody2D

export  var speed = 150.0
export  var jump_force = 350.0
export  var gravity = 800.0

const FLOOR_NORMAL = Vector2.UP
var velocity = Vector2.ZERO

func _physics_process(delta):
	var is_jump_interrupted = Input.is_action_just_released("move_up") and velocity.y < 0.0
	var direction = get_direction()
	velocity = calculate_move(velocity,direction,is_jump_interrupted)
	if Input.is_action_just_pressed("click"):
		pass # shoot
	if Input.is_action_just_pressed("ui_accept"): # posible agregado o no
		pass # dash?
	velocity = move_and_slide(velocity,FLOOR_NORMAL)


func get_direction():
	return Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("move_up") and is_on_floor() else 0.0)


func calculate_move(linear_velocity, direction,is_jump_interrupted):
	var move = linear_velocity
	move.x = direction.x * speed
	move.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		move.y = jump_force * direction.y
	if is_jump_interrupted:
		move.y = 0.0
	return move
	
	
	
	
