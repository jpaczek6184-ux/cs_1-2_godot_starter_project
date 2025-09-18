extends Node


func _on_body_entered(body):
	pass
	# TODO: Check if the object that touched the coin is the player
	if body.name == "Player":
		body.update_coins(5)
	
	# TODO: Print a message when the coin is collected
	
		print("coin collected")
	
	# TODO: Remove the coin from the game
	
		queue_free()
