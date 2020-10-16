extends CanvasLayer

func _hide():
	$Easy.visible = false
	$Normal.visible = false
	$Hard.visible = false
	$DifficultyLabel.visible = false

func _show():
	$Easy.visible = true
	$Normal.visible = true
	$Hard.visible = true
	$DifficultyLabel.visible = true
