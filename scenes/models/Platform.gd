extends KinematicBody2D

const SPEED = 4000

var canTriggerFalling = true
var falling = false
var velocity = Vector2()


func _physics_process(delta):
	if (falling):
		velocity.y = SPEED * delta
		position += velocity * delta
		
		
		
func collide_with(collision : KinematicCollision2D, collider : KinematicBody2D):
	if (canTriggerFalling):
		$PlatformTimer.start()
		canTriggerFalling = false
		
func _fall():
	falling = true
	velocity = Vector2.ZERO

func _on_PlatformTimer_timeout():
	_fall() 
	
	
