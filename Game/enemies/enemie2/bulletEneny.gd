extends Area2D


var speed = 650
var destroy = false

func _ready():
	
	$anim.frame = 0
	$anim.play("start")
	
func update_transform(value):
	transform = value
	
func _physics_process(delta):
	
	if destroy == false:
		
		position += transform.x * speed * delta
		
func _on_bullet_cannon_ghost_body_entered(body):
	
	if body.is_in_group("player"):
		
		destroy = false
		set_physics_process(false)
		$anim.frame = 0
		$anim.play("destroy")
		

func _on_anim_animation_finished():
	
	if $anim.animation == "destroy":
		queue_free()

	if $anim.animation == "start" :
		$anim.frame = 0
		$anim.play("move")
		
		


func _on_VisibilityNotifier2D_screen_exited():
	yield(get_tree().create_timer(1),"timeout")
	if destroy == true:
		queue_free()
