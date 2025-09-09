extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.setCoinsLabel(self)
	text = "Coins = 0"

func setCoinValue(integer):
	text = "Coins = " + str(integer)
