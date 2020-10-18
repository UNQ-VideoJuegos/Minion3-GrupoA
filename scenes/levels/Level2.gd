extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Interruptor.connect("triggered", $Door, "_on_Interruptor_triggered") 
