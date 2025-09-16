extends Area2D
var health = 100
var maxHealth= 100
func _on_body_entered(body):
	pass
	# TODO: Check if the object that touched the spike is the player
	# Use an if statement to check: if body.name == "Player":
	
	
	# TODO: Make the player take damage
	# Call the player's health change function: body.change_health(-10)
	
	
	# TODO: Print a message about the spike hit
	# Something like: print("Player hit spikes!")
