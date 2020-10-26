extends CanvasLayer
	
func _hide():
	$GameOver.visible = false
	$Menu.visible = false

func _show():
	$GameOver.visible = true
	$Menu.visible = true

func _on_Player_killed():
	_show()
