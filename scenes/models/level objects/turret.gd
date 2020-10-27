extends Area2D

export (PackedScene) var Bullet
export (float) var cool_down = 1
export (int) var detect_radius

var target = null
var target_dir = Vector2()
var can_shoot = true
var vis_color = Color( 0.5, 1, 0.83, 0.3 )

func _ready():
	$GunTimer.wait_time = cool_down
	var circle = CircleShape2D.new()
	$CollisionShape2D.shape = circle
	$CollisionShape2D.shape.radius = detect_radius


func _process(delta):
	update()
	if target:
		target_dir = (target.get_global_position() - global_position).normalized()
		_shoot()
	

func _draw():
	draw_circle($CollisionShape2D.position, detect_radius, vis_color)

func _shoot():
	if can_shoot:
		can_shoot = false
		var b = Bullet.instance()
		owner.add_child(b)
		b.start($Muzzle.global_position,target_dir)

	
	
func _on_StaticBody2D_body_entered(body):
	if body.name == "Player":
		target = body
		vis_color = Color( 0.86, 0.08, 0.24, 0.4 )
	


func _on_StaticBody2D_body_exited(body):
	target = null
	vis_color = Color( 0.5, 1, 0.83, 0.3 )


func _on_GunTimer_timeout():
	
	can_shoot = true
