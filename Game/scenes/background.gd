extends CanvasLayer
onready var space = get_node("space")
onready var cosmos = get_node("Cosmos")
onready var galaxy = get_node("galaxy")
onready var stars = get_node("ParallaxBackground/ParallaxStars")
onready var planets = get_node("ParallaxBackground/planets")
onready var via_lactea = get_node("ParallaxBackground/ParallaxVialactea")
var completed_appear_via_lactea = false

func _ready():
	
	GameSingleton.connect("levelUP",self,"level_UP")
	
	
func level_UP():
	
	match GameSingleton.level_player:
		1:
			space.visible = true
		2: 
			set_visibiliy_viaLactea()
		3:
			planets.visible = true
			stars.visible = true
		4:
			via_lactea.visible = true


func set_visibiliy_viaLactea():
	if completed_appear_via_lactea == false:
		completed_appear_via_lactea = true
		var mod = 0.0
		cosmos.visible = true
		while mod < 1:
			mod += 0.1 
			via_lactea.modulate = Color(1,1,1,mod)
			
		via_lactea.modulate = Color(1,1,1,1)
