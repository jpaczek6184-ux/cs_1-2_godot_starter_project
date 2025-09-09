extends Node
var max_health = 10
var health = max_health
var coins = 0

var coins_text: Label
var health_text: Label

func setCoinsLabel(label):
	coins_text = label

func setHealthLabel(label):
	health_text = label
	
func add_coin():
	coins += 1
	coins_text.text = "Coins = " + str(coins)
	
func change_health(amount):
	health += amount
	health_text.text = "Health = " + str(health)
	if health < 1:
		die()

func die():
	health_text.text = "Dead"
	
