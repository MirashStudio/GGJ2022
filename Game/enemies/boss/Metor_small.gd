extends Area2D

var speed = 500 



func _physics_process(delta):
	
	position += speed


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Metor_small_body_entered(body):
	if body.is_in_group("player"):
		GameSingleton.sub_life(5)
