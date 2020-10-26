extends CanvasLayer

func _hide():
	$KeyMapLabel.visible = false
	$BackButtonKeyMap.visible = false
	$keys.visible = false

func _show():
	$KeyMapLabel.visible = true
	$keys.visible = true
	$BackButtonKeyMap.visible = true
