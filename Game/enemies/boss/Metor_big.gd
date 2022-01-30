extends Area2D

var speed = 900



func update_transform(value):
	transform = value
	
func _physics_process(delta):
	
		position += transform.x * speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Metor_small_body_entered(body):
	
	if body.is_in_group("player"):
		GameSingleton.sub_life(20)
		queue_free()
