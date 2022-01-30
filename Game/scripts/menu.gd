extends Node2D


func _ready():
	
	yield(get_tree().create_timer(0.2),"timeout")
	$bt_play.grab_focus()

func _on_bt_play_pressed():
	$effect_bt_pressed.play()
	select_name()
	yield(get_tree().create_timer(0.5),"timeout")
	AudioSystem.play_all()
	get_tree().change_scene("res://scenes/level.tscn")


func select_name():
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(1,4)
	match num:
		
		1:
			$Label.text = " Gabriel Gay"
		2:
			$Label.text = " Henrrique Gay"
		3:
			$Label.text = " Kayo Gayzão"
		4:
			$Label.text = "Rodrigo YAG"
		5:
			$Label.text = "Gilmar GOSTOSO"


func _on_bt_controls_pressed():
	$effect_bt_pressed.play()
	$controls.visible = true
	$bt_back.visible = true
	pass # Replace with function body.


func _on_bt_credts_pressed():
	$effect_bt_pressed.play()
	$credits.visible = true
	$bt_back.visible = true
	pass # Replace with function body.


func _on_bt_exit_pressed():
	$effect_bt_pressed.play()
	get_tree().quit()


func _on_bt_play_focus_entered():
	$effect_bt_focused.play()


func _on_bt_controls_focus_entered():
	$effect_bt_focused.play()


func _on_bt_credts_focus_entered():
	$effect_bt_focused.play()


func _on_bt_exit_focus_entered():
	$effect_bt_focused.play()


func _on_bt_back_pressed():
	$effect_bt_pressed.play()
	$controls.visible = false
	$credits.visible = false
	$bt_back.visible = false
