extends Area2D



func _on_peak_body_entered(body):
	if body.name == "Player":
		body.kill()
	elif body.is_in_group("plataform"):
		body.destroy()
