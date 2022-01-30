extends Area2D


var rng = RandomNumberGenerator.new()
var AmountXP = 0
var colect = false
var in_screen = false

func _ready():
	
	GameSingleton.connect("playerDeath",self,"destroy")
	GameSingleton.connect("levelUP",self,"restart_parameters")
	select_values()
	scale_set()
	select_color()
	
func select_values():
	
	rng.randomize()
	match GameSingleton.level_player:
		
		0:
			AmountXP = rng.randi_range(1,10)
		1:
			AmountXP = rng.randi_range(10,20)
		2:
			AmountXP = rng.randi_range(21,49)
		3:
			AmountXP = rng.randi_range(50,100)
	
	return AmountXP

func scale_set():
	
	if AmountXP > 1 and AmountXP <= 10:
		var scaleValue = rng.randf_range(0.05,0.2)
		scale = Vector2(scaleValue,scaleValue)
	if AmountXP > 11 and AmountXP <= 20:
		var scaleValue = rng.randf_range(0.2,0.6)
		scale = Vector2(scaleValue,scaleValue)
	if AmountXP > 21 and AmountXP <= 49:
		var scaleValue = rng.randf_range(0.7,1.2)
		scale = Vector2(scaleValue,scaleValue)
	if AmountXP > 50 and AmountXP <= 100:
		var scaleValue = rng.randf_range(1.2,1.5)
		scale = Vector2(scaleValue,scaleValue)

func select_color():
	
	rng.randomize()
	var colorNUM = rng.randi_range(1,2)
	match colorNUM:
		1:
			$Icon.play("motion1")
		2:
			$Icon.play("motion2")

func restart_parameters():
	
	if in_screen == false and colect == false:
		select_values()
		scale_set()
		select_color()

func Hide():
	$colect.play()
	while scale.x > 0:
		yield(get_tree().create_timer(0.02),"timeout")
		scale.x -= 0.1
		scale.y -= 0.1
		if $colect.pitch_scale > 0.50:
			$colect.pitch_scale -= 0.1
	scale = Vector2(0,0)
	colect = true


func destroy():
	
	#while scale.x > 0:
		#yield(get_tree().create_timer(0.02),"timeout")
		#scale.x -= 0.1
		#scale.y -= 0.1
		
	queue_free()
	
func _on_energy_point_area_entered(area):
	
	if area.is_in_group("player"):
		GameSingleton.add_XP(AmountXP)
		Hide()

func _on_VisibilityNotifier2D_screen_exited():
	
	in_screen = false
	if colect == true:
		
		yield(get_tree().create_timer(10),"timeout")
		if  GameSingleton.level_player < 4:
			colect = false 
			while scale.x < 0.5:
				yield(get_tree().create_timer(0.02),"timeout")
				scale.x += 0.1
				scale.y += 0.1
			
			
		scale_set()

func _on_VisibilityNotifier2D_screen_entered():
	
	in_screen = true
