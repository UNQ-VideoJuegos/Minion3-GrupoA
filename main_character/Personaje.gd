extends KinematicBody2D

signal shoot

export  var speed = 150.0
export  var jump_force = 350.0
export  var gravity = 800.0
export (PackedScene) var Bullet # recordar inicializar en el inspector
export (float) var gun_cooldown = 0.2
export (int) var dash_impulse = 2000

const FLOOR_NORMAL = Vector2.UP
var velocity = Vector2.ZERO
var can_shoot = true

var can_dash = true
var dash_direction : Vector2

var jump_intents = 2


func _ready():
	$GunTimer.wait_time = gun_cooldown

func shoot():
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		var dir = Vector2(1,0).rotated($GunPosition.global_rotation)
		emit_signal("shoot",Bullet,$GunPosition.global_position,dir)

func _physics_process(delta):
	$GunPosition.look_at(get_global_mouse_position())
	var is_jump_interrupted = Input.is_action_just_released("move_up") and velocity.y < 0.0
	var direction = control()
	direction.y = jump()
	velocity = calculate_move(velocity,direction,is_jump_interrupted)
	if Input.is_action_just_pressed("click"):
		shoot()
	if Input.is_action_just_pressed("ui_accept"): # posible agregado o no
		dash()
	velocity = move_and_slide(velocity,FLOOR_NORMAL)



func jump():
	var dir = 0.0
	if is_on_floor():
		jump_intents = 2
	if Input.is_action_just_pressed("move_up") and jump_intents > 0:
		dir = -1.0
		jump_intents -=1
	return dir

func control():
	var dir = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		dir.x = -1.0
		$Sprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		dir.x = 1.0
		$Sprite.flip_h = false
	return dir

func dash():
	if is_on_floor():
		can_dash = true
	if Input.is_action_pressed("move_left"):
		dash_direction = Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		dash_direction = Vector2.RIGHT
	if can_dash:
		can_dash = false
		velocity += dash_direction.normalized() * dash_impulse
		move_and_slide(velocity)

func calculate_move(linear_velocity, direction,is_jump_interrupted):
	var move = linear_velocity
	move.x = direction.x * speed
	move.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		move.y = jump_force * direction.y
	if is_jump_interrupted:
		move.y = 0.0
	return move




func _on_GunTimer_timeout():
	can_shoot = true
