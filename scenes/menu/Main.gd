extends Node2D

func _on_StartGame_pressed():
	$WelcomeHUD._hide()
	get_tree().change_scene("res://scenes/levels/Level1.tscn")
	if (!$BackgroundSound.playing && $WelcomeHUD/OptionsHUD.backgroundSound):
		$BackgroundSound.play()
	
func _on_Menu_pressed():
	$GameOverHUD._hide()
	$GamerOverSound.stop()
	$WelcomeHUD._show()

func _on_Player_hit():
	$GamerOverSound.play()
	$BackgroundSound.stop()
	$GameOverHUD._show()
	_clean_all_elements()
	
func _clean_all_elements():
	var array = []
	for elements in array: _clean_elements(elements)
	$Player.hide()
	
func _clean_elements(elements):
	for element in elements:
			element.hide()
			element.set_deferred("disabled", true)
			element.queue_free()
