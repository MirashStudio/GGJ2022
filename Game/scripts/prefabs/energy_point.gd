extends Area2D


var rng = RandomNumberGenerator.new()
var AmountXP = 0

func _ready():
	
	select_values()
	scale_set()
	select_color()
	
	
func select_values():
	
	rng.randomize()
	
	match GameSingleton.level_palyer:
		
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
		var scaleValue = rng.randf_range(0.05,0.3)
		scale = Vector2(scaleValue,scaleValue)
	if AmountXP > 11 and AmountXP <= 20:
		var scaleValue = rng.randf_range(0.4,0.9)
		scale = Vector2(scaleValue,scaleValue)
	if AmountXP > 21 and AmountXP <= 49:
		var scaleValue = rng.randf_range(1,1.5)
		scale = Vector2(scaleValue,scaleValue)
	if AmountXP > 50 and AmountXP <= 100:
		var scaleValue = rng.randf_range(1.6,2)
		scale = Vector2(scaleValue,scaleValue)

	
	
func select_color():
	
	rng.randomize()
	var colorNUM = rng.randi_range(1,2)
	match colorNUM:
		
		1:
			$Icon.play("motion1")
		2:
			$Icon.play("motion2")
	
	
func destroy():
	
	while scale.x > 0:
		yield(get_tree().create_timer(0.02),"timeout")
		scale.x -= 0.1
		scale.y -= 0.1
	scale = Vector2(0,0)
	queue_free()


func _on_energy_point_area_entered(area):
	if area.is_in_group("player"):
		GameSingleton.add_XP(AmountXP)
		destroy()
