extends Node2D

var rng = RandomNumberGenerator.new()
var posRefer = Vector2(10,10)
var delay = 2

func _ready():
	
	GameSingleton.connect("levelUP",self,"spaw_enemy")
	AudioSystem.play_track("faixa1")
	yield(get_tree().create_timer(1),"timeout")
	spaw_pointsEnergy()


func spaw_pointsEnergy():
	
	for x in 30:
		rng.randomize()
		var xAdd = rng.randf_range(500,1000)
		posRefer.x += xAdd
		posRefer.y = 100
		for y in 30:
			rng.randomize()
			var yAdd = rng.randf_range(100,1000)
			posRefer.y += yAdd
			create_pointEnergy(posRefer)
	
	
func create_pointEnergy(pos):
	
	rng.randomize()
	var pointEnergy = preload("res://scenes/prefabs/energy_point.tscn").instance()
	get_parent().add_child(pointEnergy)
	pointEnergy.global_position = pos
	var posX = rng.randf_range(100,800)
	pointEnergy.global_position.x += posX
	#print(pos)


func create_black_hole():
	
	rng.randomize()
	var leftOrRight = rng.randf_range(0,100)
	var BH = preload("res://enemies/enemie1/enemie1.tscn").instance()
	get_parent().add_child(BH)
	BH.global_position = GameSingleton.player_target 
	if leftOrRight <= 50:
		BH.global_position.x += 1500
	else:
		BH.global_position.x -= 1500
	

func create_eye_SAURON():

	rng.randomize()
	var leftOrRight = rng.randf_range(0,100)
	var BH = preload("res://enemies/enemie2/enemie2.tscn").instance()
	get_parent().add_child(BH)
	BH.global_position = GameSingleton.player_target 
	if leftOrRight <= 50:
		BH.global_position.x += 1500
	else:
		BH.global_position.x -= 1500

func spaw_enemy():
	
	yield(get_tree().create_timer(delay),"timeout")
	if GameSingleton.player_death == false:
		if GameSingleton.level_player <= 1:
			create_black_hole()
			spaw_enemy()
		if GameSingleton.level_player > 1 and GameSingleton.level_player < 4:
			rng.randomize()
			delay = 1.6
			var enemy_select = rng.randi_range(1,2)
			if enemy_select == 1:
				create_black_hole()
			else:
				create_eye_SAURON()
			spaw_enemy()
		change_scene_to_boss()


func _on_left_body_entered(body):
	
	if body.is_in_group("player"):
		body.global_position.x = 27000


func _on_right_body_entered(body):
	if body.is_in_group("player"):
		body.global_position.x = -1000


func _on_top_body_entered(body):
	if body.is_in_group("player"):
		body.global_position.y = 19000 


func _on_botton_body_entered(body):
	if body.is_in_group("player"):
		body.global_position.y = -5000


func change_scene_to_boss():
	if GameSingleton.level_player >= 4:
		yield(get_tree().create_timer(1.5),"timeout")
		GameSingleton.player_in_boss = true
		$anim_scene.play("motion")
		yield(get_tree().create_timer(1.2),"timeout")
		get_tree().change_scene("res://scenes/levelBoss.tscn")
