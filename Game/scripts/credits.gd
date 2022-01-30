extends Node2D

func _ready():
	
	$CanvasLayer/background/bt_exit.grab_focus()
	
func _on_bt_exit_pressed():
	$effect_bt_pressed.play()
	get_tree().quit()

func _on_bt_exit_focus_entered():
	$effect_bt_focused.play()
