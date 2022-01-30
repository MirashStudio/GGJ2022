extends Control

func _ready():
	$CanvasLayer/ColorRect/bt_restart.grab_focus()
	
func _on_bt_restart_pressed():
	
	$effect_bt_pressed.play()
	yield(get_tree().create_timer(0.5),"timeout")
	AudioSystem.reset_all()
	AudioSystem.play_all()
	GameSingleton.reset_parameters()
	yield(get_tree().create_timer(0.1),"timeout")
	if GameSingleton.player_in_boss == false:
		get_tree().change_scene("res://scenes/level.tscn")
	else:
		get_tree().change_scene("res://scenes/levelBoss.tscn")
	
func _on_bt_exit_pressed():
	
	$effect_bt_pressed.play()
	get_tree().quit()
	
func _on_bt_restart_focus_entered():
	$effect_bt_focused.play()

func _on_bt_exit_focus_entered():
	$effect_bt_focused.play()
