extends Node2D



func _on_Personaje_shoot(bullet,gun_position,dir):
	var b = bullet.instance()
	add_child(b)
	b.start(gun_position,dir)
