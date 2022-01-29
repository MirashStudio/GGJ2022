extends Node

var level_player = 0
var level_current = level_player
var playerXP = 0
var player_target = Vector2()
var can_create_enemy = false
var life_player = 100
var player_death = false
signal levelUP
signal playerDeath

func add_XP(value):
	
	playerXP += value
	if playerXP >= 80 and playerXP <= 200:
		level_player = 1
	if playerXP >= 600 and playerXP <= 800:
		level_player = 2
		can_create_enemy = true
	if playerXP >= 2000 and playerXP <= 2500:
		level_player = 3
	if playerXP > 3000:
		level_player = 4
	check_level()



func check_level():
	
	if level_player != level_current:
		level_current = level_player
		emit_signal("levelUP")

func sub_life(value):
	
	life_player -= value
	print(life_player)
	if life_player <= 0:
		life_player = 0
		player_death = true
		AudioSystem.reset_all()
		emit_signal("playerDeath")
func reset_parameters():
	
	level_player = 0
	level_current = level_player
	playerXP = 0
	player_target = Vector2()
	can_create_enemy = false
	life_player = 100
	player_death = false
	
