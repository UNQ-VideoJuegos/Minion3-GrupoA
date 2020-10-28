extends KinematicBody2D

signal health_updated(health)
signal killed()

export  var color = Color.white
export  var speed = 300.0
export  var jump_force = 400.0
export  var gravity = 800.0
export (PackedScene) var Bullet # recordar inicializar en el inspector
export (float) var gun_cooldown = 0.2
export (int) var dash_impulse = 60
export (float) var dash_cooldown = 2
export (float) var max_health = 100

onready var health = max_health setget _set_health
onready var invulnerability_timer = $invulnerabilityTimer
onready var effects_animation = $Body/EffectsAnimation

const FLOOR_NORMAL = Vector2.UP
var velocity = Vector2.ZERO
var can_shoot = true
var can_dash = true
var dash_direction : Vector2 = Vector2.RIGHT
var jump_intents = 2

func _ready():
	$GunTimer.wait_time = gun_cooldown
	$DashTimer.wait_time = dash_cooldown
	modulate = Color.orange
	$AnimatedSprite.play("idle")

func shoot():
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		_shoot_bullet()

func _shoot_bullet(): 
	var dir = Vector2(1,0).rotated($GunPosition.global_rotation)
	var b = Bullet.instance()
	owner.add_child(b)
	b.start($GunPosition.global_position,dir)
	
func _physics_process(delta):
	$GunPosition.look_at(get_global_mouse_position())
	
	var is_jump_interrupted = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction = control()
	direction.y = jump()
	if Input.is_action_just_pressed("click"):
		shoot()
	if Input.is_action_just_pressed("dash"): 
		direction = dash()
	velocity = calculate_move(velocity,direction,is_jump_interrupted)
	
	if velocity.x != 0 and is_on_floor():
		$AnimatedSprite.animation = "idle"
	elif velocity.y < 0 or velocity.x != 0 and !is_on_floor():
		$AnimatedSprite.animation = "jump"
	else:
		$AnimatedSprite.animation = "idle"
		
	velocity = move_and_slide(velocity,FLOOR_NORMAL)
	_handleCollision()
	
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()

func jump():
	var dir = 0.0
	if is_on_floor():
		jump_intents = 2
	if Input.is_action_just_pressed("jump") and jump_intents > 0:
		dir = -1.0
		$JumpSound.play()
		jump_intents -=1
	return dir

func control():
	var dir = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		dir.x = -1.0
		dash_direction = Vector2.LEFT
		$AnimatedSprite.flip_h = true
	if Input.is_action_pressed("move_right"):
		dir.x = 1.0
		dash_direction = Vector2.RIGHT
		$AnimatedSprite.flip_h = false
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


func damage(amount):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		_set_health(health - amount)
		effects_animation.play("damage")
		effects_animation.queue("flash")

func kill(): # COMENTAR PARA EVITAR MORIR CONSTANTEMENTE DE SER NECESARIO
	$GamerOverSound.play()
	$GunTimer.stop()
	$Camera2D.current = false
	$CollisionShape2D.set_deferred("disable",true)
	hide() # no es la mejor solucion porque se puede seguir usando el personaje
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene("res://scenes/menu/GameOverHUD.tscn")
	queue_free()
	

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			kill()

func _on_invulnerabilityTimer_timeout():
	effects_animation.play("rest")

func _on_Player_killed():
	kill()
