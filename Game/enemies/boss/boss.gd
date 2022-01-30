extends Node2D

var rng = RandomNumberGenerator.new()
var numSelect = 0
var death = false
var can_damage = true
var delay_attack
var life = 40
var maxATC = 2
var sequence_attack = [1,2,3,4,5,6,7,8,9,10,5,6,7,4,3,8,2,9,10,1,1,10,2,9,3,8,4,7,5,6,10,9,8,7,6,5,7,3,2,1]

#e7e7e7
func _ready():
	$animBoss.play("idle")
	yield(get_tree().create_timer(3),"timeout")
	select_attack()
	AudioSystem.play_track("faixa5")
	$CanvasLayer/anim_hud.play("motion")
	
func _physics_process(delta):
	
	$posMeteorBig.look_at(GameSingleton.player_target)

func select_attack():

	if death == false:
		if life <= 150:
			maxATC = 3
		rng.randomize()
		numSelect = rng.randi_range(1,maxATC)
		$animBoss.play(str("attack",numSelect)) 
		delay_attack = rng.randf_range(2,4)
		$delay_attack.wait_time = delay_attack

func tween_damage():
	$Sprite.self_modulate = Color(6,6,6,1)
	yield(get_tree().create_timer(0.02),"timeout")
	$Sprite.self_modulate = Color(1,1,1,1)
	
func select_rajadas():
	
	if life > 50:
		spaw_RajadaNormal()
	else:
		spaw_RajadaSpecial()
		
func spaw_RajadaSpecial():
	for i in sequence_attack.size():
		yield(get_tree().create_timer(0.1),"timeout")
		if has_node(str("pos", sequence_attack[i])):
			create_MeteorSmall(get_node(str("pos", sequence_attack[i])).global_position)
			

func spaw_RajadaNormal():
	for i in 10:
		yield(get_tree().create_timer(0.2),"timeout")
		if has_node(str("pos", i)):
			create_MeteorSmall(get_node(str("pos", i)).global_position)
			
func create_MeteorSmall(pos):
	
	if death == false:
		print("create meteor ",pos)
		var bullet = preload("res://enemies/boss/Metor_small.tscn")
		var bl = bullet.instance()
		get_parent().add_child(bl)
		bl.global_position = pos
		

func create_MeteorBig():
	
	if death == false:
		
		var bullet = preload("res://enemies/boss/Metor_big.tscn")
		var bl = bullet.instance()
		get_parent().add_child(bl)
		bl.update_transform($posMeteorBig.transform)
		bl.global_position = $posMeteorBig.global_position
		

		
func _on_animBoss_animation_finished(anim_name):
	
	print(anim_name)
	if anim_name  == "attack1" or anim_name  == "attack2" or anim_name  == "attack3":
		
		if death == false:
			
			$animBoss.play("idle")
			$delay_attack.start()
			#yield(get_tree().create_timer(delay_attack),"timeout")
			

func create_spaw_black_hole():
	delay_attack = 8
	rng.randomize()
	var leftOrRight = rng.randf_range(0,100)
	var BH = preload("res://enemies/boss/black_hole.tscn").instance()
	get_parent().add_child(BH)
	BH.global_position = $posMeteorBig.global_position


func _on_delay_attack_timeout():
	
	select_attack()


func _on_area_headBoss_area_entered(area):
	
	if area.is_in_group("bullet") and can_damage == true:
		
		life -= 1
		tween_damage()
		$CanvasLayer/life_container/bar_life.value = life
