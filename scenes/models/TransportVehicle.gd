extends Area2D

const SPEED = 150

export var next_scene: PackedScene
export var color = Color.green
var moving = false

func _ready():
	modulate = color

func _physics_process(delta):
	if (moving):
		position.x += SPEED * delta
		 
func _get_configuration_warning() -> String:
	return "The property Next Level can't be empty" if not next_scene else ""
	
func _on_Portal_body_entered(body):
	if (body.get_name() == "Player"):
		body.hide()
		$TransporterSound.play()
		yield(get_tree().create_timer(.5), "timeout")
		moving = true
		
func teleport() -> void:
	get_tree().change_scene_to(next_scene)

func _on_VisibilityNotifier2D_screen_exited():
	if (moving):
		teleport()
		queue_free()
