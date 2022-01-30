extends Area2D

var player_in_nucleo = false
var node_refer
var target = GameSingleton.player_target

func _physics_process(delta):
	
	position.y += 1
	if !node_refer == null:
		target = GameSingleton.player_target
		var direction = (position - target ).normalized()
		var motion = direction * 250 * delta
		if has_node(node_refer):
			get_node(node_refer).global_position += motion
		
		if player_in_nucleo == true:
			GameSingleton.sub_life(1)

func _on_black_hole_body_entered(body):
	if body.is_in_group("player"):
		node_refer = get_path_to(body)

func _on_nucleo_body_entered(body):
	if body.is_in_group("player"):
		player_in_nucleo = true


func _on_nucleo_body_exited(body):
	if body.is_in_group("player"):
		player_in_nucleo = false


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
