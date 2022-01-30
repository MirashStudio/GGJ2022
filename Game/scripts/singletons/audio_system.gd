extends Node2D


func play_track(value:String):
	
	if has_node(value):
		get_node(value).volume_db = -15
		
		
func reset_all():
	
	$faixa1.volume_db = -80
	$faixa2.volume_db = -80
	$faixa3.volume_db = -80
	$faixa4.volume_db = -80
	$faixa5.volume_db = -80
	
func play_all():
	
	$faixa1.play()
	$faixa2.play()
	$faixa3.play()
	$faixa4.play()
	$faixa5.play()


func play_levelBoss():
	
	$faixa1.volume_db = -15
	$faixa2.volume_db = -15
	$faixa3.volume_db = -15
	$faixa4.volume_db = -15
	$faixa5.volume_db = -15
