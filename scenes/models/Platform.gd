extends KinematicBody2D

export var SPEED = 8000
export var playFallingAnimation = true

var canTriggerFalling = true
var falling = false
var velocity = Vector2()

func _ready():
	add_to_group("plataform")	

func _physics_process(delta):
	if (falling):
		velocity.y = SPEED * delta
		position += velocity * delta		
		
func collide_with(collision : KinematicCollision2D, collider : KinematicBody2D):
	if (canTriggerFalling):
		$PlatformTimer.start()
		canTriggerFalling = false
		_fall()
		
func _fall():
	velocity = Vector2.ZERO
	if (playFallingAnimation):
		$ShakeAnimation.play("PlatformAnimation")
		yield(get_tree().create_timer(.2), "timeout")
		$ShakeAnimation.stop()
	falling = true
	
	
func destroy():
	queue_free()
	
func _on_PlatformTimer_timeout():
	pass 
	
	
