extends Node2D

signal triggered

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Interruptor_area_entered(area):
	if (area.get_name() == "Bullet"):
		emit_signal('triggered') 
		$Sprite.hide()
		$AnimatedSprite.show()
		$AnimatedSprite.play()
		yield(get_tree().create_timer(.5), "timeout")
		queue_free()
