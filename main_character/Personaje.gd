extends KinematicBody2D

signal shoot

export  var speed = 150.0
export  var jump_force = 350.0
export  var gravity = 800.0
export (PackedScene) var Bullet # recordar inicializar en el inspector
export (float) var gun_cooldown = 0.3


const FLOOR_NORMAL = Vector2.UP
var velocity = Vector2.ZERO
var can_shoot = true

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
	#var direction = get_direction()
	var direction = control()
	velocity = calculate_move(velocity,direction,is_jump_interrupted)
	if Input.is_action_just_pressed("click"):
		shoot()
	if Input.is_action_just_pressed("ui_accept"): # posible agregado o no
		pass # dash?
	velocity = move_and_slide(velocity,FLOOR_NORMAL)


func get_direction():
	return Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("move_up") and is_on_floor() else 0.0)

func control():
	var dir = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		dir.x = -1.0
		$Sprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		dir.x = 1.0
		$Sprite.flip_h = false
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		dir.y = -1.0
	else :
		0.0
	return dir

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
