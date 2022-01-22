extends Node

var level_palyer = 0
var rng = RandomNumberGenerator.new()
var AmountXP = 0

func _ready():
	
	select_values()
	
	
	
func select_values():
	rng.randomize()
	match GameSingleton.level_palyer:
		1:
			AmountXP = rng.randf_range(1,10)
		2:
			AmountXP = rng.randf_range(10,20)
		3:
			AmountXP = rng.randf_range(20,40)
		4:
			AmountXP = rng.randf_range(50,100)
			
	return AmountXP
