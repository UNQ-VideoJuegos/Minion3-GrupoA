extends Node2D

func _ready():
	$Interruptor.connect("triggered", $Door, "_on_Interruptor_triggered") 
