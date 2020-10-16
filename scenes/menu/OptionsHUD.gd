extends CanvasLayer
enum {EASY = 1, NORMAL = 2, HARD = 3}
export var dificulty = NORMAL
export var backgroundSound = true
export var diamondSound = true

func _ready():
	$DifficultyHUD._hide()
	_show()

func _on_Easy_pressed():
	dificulty = EASY
	$DifficultyHUD._hide()
	_show()

func _on_Normal_pressed():
	dificulty = NORMAL
	$DifficultyHUD._hide()
	_show()

func _on_Hard_pressed():
	dificulty = HARD
	$DifficultyHUD._hide()
	_show()

func _show():
	$OptionName.visible = true
	$BackButton.visible = true
	$AudioButton.visible = true
	$DifficultyButton.visible = true

func _hide():
	$OptionName.visible = false
	$BackButton.visible = false
	$AudioButton.visible = false
	$DifficultyButton.visible = false

func _on_DifficultyButton_pressed():
	_hide()
	$DifficultyHUD._show()

func _on_AudioButton_pressed():
	_hide()
	$AudioHUD._show()

func _on_BackButtonAudio_pressed():
	$AudioHUD._hide()
	_show()


func _on_BackgroundSoundBtn_pressed():
	var theme = Theme.new()
	var bgs = get_tree().get_root().get_node("Main/BackgroundSound")
	if (bgs.playing):
		bgs.stop()
		backgroundSound = false
		theme.set_color("font_color", "Button", Color.red)
	else:
		bgs.play()
		backgroundSound = true
		theme.set_color("font_color", "Button", Color.green)
	$AudioHUD/BackgroundSoundBtn.theme = theme
