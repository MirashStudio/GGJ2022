extends CanvasLayer
onready var space = get_node("space")
onready var cosmos = get_node("Cosmos")
onready var galaxy = get_node("galaxy")
onready var stars = get_node("ParallaxBackground/ParallaxStars")
onready var planets = get_node("ParallaxBackground/planets")
onready var via_lactea = get_node("ParallaxBackground/ParallaxVialactea")
var completed_appear_via_lactea = false
var completed_appear_galaxy = false
var completed_appear_space = false

func _ready():
	
	GameSingleton.connect("levelUP",self,"level_UP")
	yield(get_tree().create_timer(2),"timeout")
	space = get_node("space")
	cosmos = get_node("Cosmos")
	stars = get_node("ParallaxBackground/ParallaxStars")
	planets = get_node("ParallaxBackground/planets")
	via_lactea = get_node("ParallaxBackground/ParallaxVialactea")
	print(space)
	print(via_lactea)
	print(cosmos)
	print(planets)
	print(stars)
	set_visibiliy_space()
	set_visibiliy_viaLactea()
	
func level_UP():
	
	match GameSingleton.level_player:
		1:
			set_visibiliy_space()
		2: 
			set_visibiliy_viaLactea()
		3:
			planets.visible = true
			stars.visible = true
		4:
			
			set_visibiliy_galaxy()


func set_visibiliy_viaLactea():
	if completed_appear_via_lactea == false:
		completed_appear_via_lactea = true
		var mod = 0.0
		via_lactea.modulate = Color(1,1,1,0)
		cosmos.visible = true
		while mod < 1:
			yield(get_tree().create_timer(0.02),"timeout")
			mod += 0.01 
			via_lactea.modulate = Color(1,1,1,mod)
			
		via_lactea.modulate = Color(1,1,1,1)


func set_visibiliy_galaxy():
	if completed_appear_galaxy == false:
		completed_appear_galaxy = true
		"""galaxy.visible = true
		var mod = 0.0
		galaxy.modulate = Color(1,1,1,0)
		while mod < 1:
			yield(get_tree().create_timer(0.02),"timeout")
			mod += 0.01 
			galaxy.modulate = Color(1,1,1,mod)"""
			
		galaxy.modulate = Color(1,1,1,1)




func set_visibiliy_space():
	
	if completed_appear_space == false:
		completed_appear_space = true
		$"../animlevel".play("space")
		"""space.visible = true
		var mod = 0.0
		space.modulate = Color(1,1,1,0)
		while mod < 1:
			yield(get_tree().create_timer(0.02),"timeout")
			mod += 0.01 
			space.modulate = Color(1,1,1,mod)
			
		space.modulate = Color(1,1,1,1)"""
