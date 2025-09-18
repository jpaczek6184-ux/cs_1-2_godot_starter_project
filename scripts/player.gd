extends CharacterBody2D
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D

var xSpeed = 300.0
var xDirection = 0
var facing = "down"
var ySpeed = 300.0
var yDirection = 0
var health = 100
var maxHealth = 100
var coins:int=0
# TODO: Add health system variables
# var health = ?

# var maxHealth = ?

func update_health(amount:int):
	health+=amount
	if health > maxHealth:
		health = maxHealth
	print("health changed by"+ str (amount))
	print ("health is now "+ str(health))
func update_coins(amount:int):
	coins+=amount

# TODO: Add projectile scene for shooting
# var projectile_scene = preload("res://scenes/projectile.tscn")

func _physics_process(_delta):
	# TODO: Get horizontal input (left/right keys)
	# Input.get_axis checks two keys and gives us a number:
	# - When LEFT is pressed: returns -1.0
	# - When RIGHT is pressed: returns 1.0  
	# - When NOTHING is pressed: returns 0.0
	
	
	
	
	xDirection = Input.get_axis("ui_left", "ui_right")
	velocity.x = xSpeed * xDirection
	# TODO: Get vertical input (up/down keys)  
	# Same idea, but for up and down movement
	yDirection = Input.get_axis("ui_up", "ui_down")
	velocity.y = ySpeed * yDirection

	# TODO: Calculate X movement by multiplying direction × speed
	# This gives us the actual pixels to move this frame
	# If direction is 1 and speed is 300, we get 300 pixels right
	# If direction is -1 and speed is 300, we get -300 pixels (left)
	#print("player Health: ", health)
	
	# TODO: Calculate Y movement the same way
	
	
	# TODO: Set the player's velocity (how fast they're moving)
	# Godot's CharacterBody2D uses a velocity system
	
	
	
	# TODO: Update facing direction based on movement
	# Use if statements to check xDirection and yDirection
	# Set facing to "right", "left", "down", or "up"
	# Only update facing when actually moving (direction != 0)
	if xDirection > 0:
		facing = "right"
	elif xDirection < 0:
		facing = "left"
	elif yDirection > 0:
		facing = "down"
	elif yDirection < 0:
		facing = "up"
	
	if velocity.x == 0 and velocity.y == 0:
		_animation_player.play("idle_" + facing)
	else:
		_animation_player.play("walk_" + facing)
	
	# TODO: Update animation based on facing direction
	# Call your update_animation() function here
	update_animation()
	# TODO: Actually apply the movement
	# This is a special Godot function that makes the movement happen
	move_and_slide()

# TODO: Create animation function (add this outside of _physics_process)
func update_animation():
	pass
	# TODO: Set the animation based on the facing direction
	# Use: _animation_player.play("idle_" + facing)
	# This combines "idle_" with whatever direction we're facing
	
	
	
	


# TODO: Create health change function for interactions
func change_health(amount):
	# TODO: Add amount to health (positive = heal, negative = damage)
	# TODO: Make sure health stays between 0 and maxHealth
	# TODO: Print the new health value
	# TODO: Check if health <= 0 for death (optional challenge)
	print("Health changed by: ", amount)


# TODO: Create shooting function
func shoot():
	# TODO: Create a new projectile instance
	# Look at the documentation examples in the lesson
	
	
	# TODO: Set projectile position to player position
	# Look at the "Setting Object Position" example
	
	
	# TODO: Set projectile direction using facing variable
	# Look at the "Calling Functions on Other Objects" example
	
	
	# TODO: Add projectile to the game world
	# Look at the "Adding Objects to the Game World" example
	
	
	# TODO: Print shooting confirmation
	# print("Shot projectile facing: ", facing)
	
	pass
