extends AnimationPlayer

func _ready():
	
	GameSingleton.connect("BossDeath",self,"playDeath")
	
func playDeath():
	
	play_backwards("death")
