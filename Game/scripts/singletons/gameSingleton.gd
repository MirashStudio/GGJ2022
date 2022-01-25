extends Node

var level_player = 0
var level_current = level_player
var playerXP = 0
var player_target = Vector2()
var can_create_enemy = false

signal levelUP


func add_XP(value):
	
	playerXP += value
	if playerXP >= 80 and playerXP <= 200:
		level_player = 1
	if playerXP >= 600 and playerXP <= 800:
		level_player = 2
		can_create_enemy = true
	if playerXP >= 2000:
		level_player = 3
	check_level()
	print(playerXP," ",level_player)



func check_level():
	if level_player != level_current:
		level_current = level_player
		emit_signal("levelUP")
