extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
			
func _fall():
	mode = RigidBody2D.MODE_CHARACTER

func _on_PlatformTimer_timeout():
	_fall() 

func _on_Platform_body_entered(body):
	$PlatformTimer.start()
