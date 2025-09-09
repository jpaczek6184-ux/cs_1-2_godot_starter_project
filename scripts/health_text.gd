extends Label



func _ready():
	GameManager.setHealthLabel(self)
	text = "Health = " + str(GameManager.max_health)
