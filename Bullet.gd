extends Area2D

export (int) var speed = 250
export (float) var lifetime = 1.0

var velocity = Vector2()

func start(pos,dir):
	position = pos
	rotation = dir.angle()
	$LifeTime.wait_time = lifetime
	$LifeTime.start()
	velocity = speed * dir
	

func _process(delta):
	position += velocity * delta



func _on_Bullet_body_entered(body):
	queue_free()


func _on_LifeTime_timeout():
	queue_free()
