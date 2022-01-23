extends Node2D




func _on_bt_play_pressed():
	select_name()
	yield(get_tree().create_timer(2),"timeout")
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
