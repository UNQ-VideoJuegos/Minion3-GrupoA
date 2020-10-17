extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Interruptor2.connect("triggered", $Door, "_on_Interruptor_triggered") 
	$Interruptor.connect("triggered", $Door2, "_on_Interruptor_triggered") 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
