extends Node2D

var Ball = load("res://scenes/models/Ball.tscn")
	
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			var b = Ball.instance()
			b.position = event.position
			add_child(b)
