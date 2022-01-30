extends Node2D


func _ready():
	
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play()
	yield(get_tree().create_timer(2),"timeout")
	queue_free()
