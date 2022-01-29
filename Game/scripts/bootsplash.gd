extends Control

func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	Input.set_custom_mouse_cursor(load("res://transparent.png"))

func _on_AnimationPlayer_animation_finished(anim_name):
		if anim_name == "bootsplash":
			get_tree().change_scene("res://scene/main_menu.tscn")
