extends Area2D

export (PackedScene) var Bullet
export (float) var cool_down = 1

var target = null
var target_dir = Vector2()
var can_shoot = true


func _ready():
	$GunTimer.wait_time = cool_down

func _process(delta):
	if target:
		target_dir = (target.get_global_position() - global_position).normalized()
		_shoot()
	

func _shoot():
	if can_shoot:
		can_shoot = false
		var b = Bullet.instance()
		owner.add_child(b)
		b.start($Muzzle.global_position,target_dir)

	
	
func _on_StaticBody2D_body_entered(body):
	if body.name == "Player":
		target = body
	


func _on_StaticBody2D_body_exited(body):
	target = null


func _on_GunTimer_timeout():
	
	can_shoot = true
