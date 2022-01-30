extends KinematicBody2D

var direction 
var target = Vector2()
var speed = 300
var stop_move = false
var enemie_in_area = false
var position_init = Vector2()
var check_soundmove = false
var death = false
var in_attack  = false
var damage = false
var node_refer 
var in_screen = false
var rng = RandomNumberGenerator.new()

func _ready():
	print("created")
	GameSingleton.connect("playerDeath",self,"scale_death")
	position_init = global_position
	set_scaleINIT()
	
func _physics_process(delta):
	
	target = GameSingleton.player_target
	chase(delta)
	drag_player(delta)
	$pos.look_at(target)
	
func init(pos):
	
	position = pos
	
func drag_player(delta):
	
	if !node_refer == null and death == false and in_attack:
		stop_move = true
		var direction = (position - target ).normalized()
		var motion = direction * 100 * delta
		get_node(node_refer).global_position += motion
		
		
func death_check():
	
	if death == true:
		death = false
		

func chase(delta):
	
	if stop_move == false :
		var direction = (target - position).normalized()
		var motion = direction * speed * delta
		position += motion

func create_bullet():
	if stop_move == false:
		var delay = rng.randf_range(2,4)
		var bullet = preload("res://enemies/enemie2/bulletEnemy.tscn")
		var bl = bullet.instance()
		get_parent().add_child(bl)
		bl.update_transform($pos.transform)
		bl.global_position = global_position
		yield(get_tree().create_timer(delay),"timeout")
		create_bullet()

func set_scaleINIT():
	
	rng.randomize()
	var scl = 1
	match GameSingleton.level_player:
		
		0:
			scl = rng.randf_range(0.4,0.8)
		1:
			scl = rng.randf_range(0.8,1.2)
		2:
			scl = rng.randf_range(1.2,1.6)
		3:
			scl = rng.randf_range(1.5,2.5)
	scale = Vector2(scl,scl)
	
func _on_VisibilityNotifier2D_screen_entered():
	#set_physics_process(true)
	
	in_screen = true
	$Timer.start()
	create_bullet()
	
func _on_VisibilityNotifier2D_screen_exited():
	in_screen = false
	#set_physics_process(false)
	pass
	

func scale_death():
	
	while scale.x > 0:
		yield(get_tree().create_timer(0.02),"timeout")
		scale.x -= 0.1
		scale.y -= 0.1
		
	if scale.x <= 0:
		queue_free()
		
func _on_area_detection_body_entered(body):
	
	if body.is_in_group("player") and death == false:
		
		node_refer = get_path_to(body)
		stop_move = true
		
		if death == false and in_attack == false:
			in_attack = true
	
func _on_area_detection_body_exited(body):
	
	if body.is_in_group("player") :
		yield(get_tree().create_timer(0.5),"timeout")

func _on_Timer_timeout():
	
	#death_check()
	#scale_death()
	#yield(get_tree().create_timer(1),"timeout")
	pass


func _on_area_detection_area_entered(area):
	
	if area.is_in_group("bullet"):
	
		set_physics_process(false)
		stop_move = true
		$Sprite/AnimationPlayer.play("enemie_death")
		$effect_death.play()
		yield(get_tree().create_timer(3),"timeout")
		queue_free()
	if area.is_in_group("player"):
		GameSingleton.sub_life(2)
