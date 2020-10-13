extends RigidBody2D

func _input(event):
	if event.is_action_pressed("ui_left"):
		set_linear_velocity(Vector2(-200,0))
	elif event.is_action_pressed("ui_right"):
		apply_impulse(Vector2(0,0), Vector2(200,0))
	elif event.is_action_pressed("ui_select"):
		apply_impulse(Vector2(-20,0), Vector2(0,-200))
	else:
		apply_impulse(Vector2(0,0), Vector2(0,0))
		#set_linear_velocity(Vector2(0,0))
