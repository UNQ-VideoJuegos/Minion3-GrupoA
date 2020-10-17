extends KinematicBody2D

export  var speed = 300.0
export  var jump_force = 400.0
export  var gravity = 800.0
export (PackedScene) var Bullet # recordar inicializar en el inspector
export (float) var gun_cooldown = 0.2
export (int) var dash_impulse = 60
export (float) var dash_cooldown = 2

const FLOOR_NORMAL = Vector2.UP
var velocity = Vector2.ZERO

var can_shoot = true
var can_dash = true
var dash_direction : Vector2 = Vector2.RIGHT

var jump_intents = 2


func _ready():
	$GunTimer.wait_time = gun_cooldown
	$DashTimer.wait_time = dash_cooldown

func shoot():
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		_shoot_bullet()

func _shoot_bullet():
	var dir = Vector2(1,0).rotated($GunPosition.global_rotation)
	var b = Bullet.instance()
	add_child(b)
	b.start($GunPosition.position, dir)
	
func _physics_process(delta):
	$GunPosition.look_at(get_global_mouse_position())
	var is_jump_interrupted = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction = control()
	direction.y = jump()
	if Input.is_action_just_pressed("click"):
		shoot()
	if Input.is_action_just_pressed("dash"): # posible agregado o no
		direction = dash()
	velocity = calculate_move(velocity,direction,is_jump_interrupted)
	velocity = move_and_slide(velocity,FLOOR_NORMAL)
	_handleCollision()
	print(can_dash)


func jump():
	var dir = 0.0
	if is_on_floor():
		jump_intents = 2
	if Input.is_action_just_pressed("jump") and jump_intents > 0:
		dir = -1.0
		jump_intents -=1
	return dir

func control():
	var dir = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		dir.x = -1.0
		dash_direction = Vector2.LEFT
		$Sprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		dir.x = 1.0
		dash_direction = Vector2.RIGHT
		$Sprite.flip_h = false
	return dir

func dash():
	var dir = Vector2.ZERO
	if can_dash:
		can_dash = false
		$DashTimer.start()
		dir = dash_direction.normalized() * dash_impulse
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


func _handleCollision():
	for i in get_slide_count():
		var col = get_slide_collision(i)
		if (col.collider.has_method("collide_with")):
			col.collider.collide_with(col, self)

func _on_DashTimer_timeout():
	can_dash = true

func _on_GunTimer_timeout():
	can_shoot = true


func _on_Area2D_area_entered(area): # codigo de ejemplo
	position.y *= area.get_gravity_vector().y



