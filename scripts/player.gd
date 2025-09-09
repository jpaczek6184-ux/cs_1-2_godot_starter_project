extends CharacterBody2D
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D

var xSpeed = 300.0
var xDirection = 0
var facing = "down"
var ySpeed = 300.0
var yDirection = 0

func _physics_process(_delta):

	# Get the input direction and handle the movement/deceleration.
	
	xDirection = Input.get_axis("ui_left", "ui_right")
	yDirection = Input.get_axis("ui_up", "ui_down")
	
	velocity.x = xSpeed * xDirection
	velocity.y = ySpeed * yDirection
	move_and_slide()
	
	if xDirection == -1:
			facing = "left"
			
	if xDirection == 1:
			facing = "right"
			
	if yDirection == -1:
			facing = "up"
			
	if yDirection == 1:
			facing = "down"
			
			
	
	if facing == "right":
		_animation_player.play("walk_right")
	if facing == "left":
		_animation_player.play("walk_left")
	if facing == "down":
			_animation_player.play("walk_down")
	if facing == "up":
			_animation_player.play("walk_up")
			
	if xDirection + yDirection == 0:
		if facing == "right":
			_animation_player.play("idle_right")
		if facing == "left":
			_animation_player.play("idle_left")
		if facing == "down":
			_animation_player.play("idle_down")
		if facing == "up":
			_animation_player.play("idle_back")
