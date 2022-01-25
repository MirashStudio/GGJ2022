extends Node2D

var rng = RandomNumberGenerator.new()
var posRefer = Vector2(100,100)
var delay = 1

func _ready():
	GameSingleton.connect("levelUP",self,"spaw_enemy")
	yield(get_tree().create_timer(1),"timeout")
	spaw_pointsEnergy()


func spaw_pointsEnergy():
	
	for x in 20:
		rng.randomize()
		var xAdd = rng.randf_range(500,1000)
		posRefer.x += xAdd
		posRefer.y = 100
		for y in 20:
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
	var BH = preload("res://enemies/enemie1.tscn").instance()
	get_parent().add_child(BH)
	BH.global_position = GameSingleton.player_target 
	if leftOrRight <= 50:
		BH.global_position.x += 1500
	else:
		BH.global_position.x -= 1500
	
	
func spaw_enemy():
		
	if GameSingleton.level_player <= 1:
		
		create_black_hole()
		delay = 2
		yield(get_tree().create_timer(delay),"timeout")
		spaw_enemy()
