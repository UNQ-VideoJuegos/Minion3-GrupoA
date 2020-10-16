extends RigidBody2D

export (int) var speed = 1000
export (int) var jump_force = -500
export (float) var gun_cooldown = 0.2
export (float) var dash_cooldown = 2
export (int) var dash_impulse = 1000

var Bullet = preload("res://scenes/models/Bullets/Bullet.tscn")

var can_shoot = true
var can_dash = true
var dash_direction : Vector2 = Vector2.RIGHT
var jump_intents = 3

func _ready():
	$ShootTimer.wait_time = gun_cooldown
	$DashTimer.wait_time = dash_cooldown

func _physics_process(delta):
	$GunPosition.position = get_global_mouse_position()
	if Input.is_action_just_pressed("click"):
		shoot()
	

func _integrate_forces(state):
	var is_on_ground = state.get_contact_count() > 0 and int(state.get_contact_collider_position(0).y) >= int(global_position.y)
	
	if Input.is_action_pressed("move_left"):
		$Sprite.flip_h = true
		dash_direction = Vector2.LEFT
		state.linear_velocity += Vector2.LEFT.normalized() * speed
	
	if Input.is_action_pressed("move_right"):
		$Sprite.flip_h = false
		dash_direction = Vector2.RIGHT
		state.linear_velocity += Vector2.RIGHT.normalized() * speed
	
	if is_on_ground:
		jump_intents = 1
		
	if Input.is_action_just_pressed("jump") and jump_intents > 0:
		jump_intents -=1
		state.apply_impulse(Vector2.ZERO,Vector2(0,jump_force))
	
	if Input.is_action_just_pressed("dash") and can_dash:
		can_dash = false
		$DashTimer.start()
		state.apply_central_impulse(dash_direction.normalized() * dash_impulse)


func shoot():
	if can_shoot:
		can_shoot = false
		$ShootTimer.start()
		
		_shoot_bullet()

func _shoot_bullet():
	var dir = Vector2(1,0).rotated($GunPosition.global_rotation)
	var b = Bullet.instance()
	add_child(b)
	print($GunPosition.position)
	b.start($GunPosition.position, dir)


func _on_DashTimer_timeout():
	can_dash = true


func _on_ShootTimer_timeout():
	can_shoot = true
