extends Node2D

func _ready():
	$doors/Interruptor.connect("triggered", $doors/Door1, "_on_Interruptor_triggered") 
	$doors/Interruptor2.connect("triggered", $doors/Door6, "_on_Interruptor_triggered")
	
	$doors/Interruptor3.connect("triggered", $doors/Door2, "_on_Interruptor_triggered")
	$doors/Interruptor4.connect("triggered", $doors/Door3, "_on_Interruptor_triggered")
	$doors/Interruptor5.connect("triggered", $doors/Door4, "_on_Interruptor_triggered")
	$doors/Interruptor6.connect("triggered", $doors/Door5, "_on_Interruptor_triggered")
	$doors/Interruptor7.connect("triggered", $doors/DoorFinal, "_on_Interruptor_triggered")
	
	
	
