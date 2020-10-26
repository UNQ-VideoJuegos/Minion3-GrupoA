extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Lava_body_entered(body):
	if body.get_name() == "Player":
		body.damage(100)
