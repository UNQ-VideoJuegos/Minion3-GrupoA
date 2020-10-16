extends CanvasLayer

func _hide():
	$BackgroundSoundBtn.visible = false
	$AudioLabel.visible = false
	$BackButtonAudio.visible = false

func _show():
	$BackgroundSoundBtn.visible = true
	$AudioLabel.visible = true
	$BackButtonAudio.visible = true
