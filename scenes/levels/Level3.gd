extends Node2D

func _ready():
	
	Global.actual_scene = "res://scenes/levels/Level3.tscn"
	
	$doors/Interruptor.connect("triggered", $doors/Door1, "_on_Interruptor_triggered") 
	$doors/Interruptor2.connect("triggered", $doors/Door6, "_on_Interruptor_triggered")
	
	$doors/Interruptor3.connect("triggered", $doors/Door2, "_on_Interruptor_triggered")
	$doors/Interruptor4.connect("triggered", $doors/Door3, "_on_Interruptor_triggered")
	$doors/Interruptor5.connect("triggered", $doors/Door4, "_on_Interruptor_triggered")
	$doors/Interruptor6.connect("triggered", $doors/Door5, "_on_Interruptor_triggered")
	$doors/Interruptor7.connect("triggered", $doors/DoorFinal, "_on_Interruptor_triggered")
	
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == true:
			get_tree().paused = false
		else:
			get_tree().paused = true
