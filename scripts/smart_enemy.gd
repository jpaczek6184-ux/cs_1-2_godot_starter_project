extends CharacterBody2D

# TODO: Create enum for basic AI states
# Look at "Understanding Enums" documentation  
# You need IDLE and PATROL states

# TODO: Add state tracking variable
# Look at "Using Enum Values" documentation
# Track which state the enemy is currently in

# TODO: Add timer variables
# Look at "Timer-Based Behavior" documentation
# You need to track time and know when to switch states

# TODO: Add patrol variables
# Look at "Moving Between Points" documentation
# You need patrol points and movement speed

func _ready():
	# TODO: Set up starting conditions
	# What state should the enemy start in?
	# What are the two patrol points?
	pass

func _physics_process(delta):
	# TODO: Handle current state behavior
	# Look at "Organizing State Behavior" documentation
	# What should happen during IDLE? What about PATROL?
	
	# TODO: Update timer and check for state switches
	# Look at "Timer-Based Behavior" documentation
	# When should you switch from IDLE to PATROL and vice versa?
	pass

# TODO: Create functions for each state (optional but recommended)
# Look at "Organizing State Behavior" documentation  

# TODO: Add debug print statements
# Print current state so you can see what's happening
