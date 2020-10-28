extends KinematicBody2D


const SPEED = 20
const DOOR_LIMIT = -6.5

var opening = false
var velocity = Vector2()

func _ready():
	pass

func open():
	$DoorTimer.start()
	
func _physics_process(delta):
	if (opening):
		position.y -= SPEED * delta
		if (position.y < DOOR_LIMIT):
			opening = false

func _on_DoorTimer_timeout():
	opening = true
