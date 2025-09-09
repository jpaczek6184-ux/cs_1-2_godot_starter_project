# Lesson 6: Stationary Turrets - Enemy Shooting

## What We're Learning Today
- How to detect other objects in the game world
- How to calculate direction between two positions
- How to implement basic AI behavior with timers
- How to reuse projectile systems for enemies

## What We're Building
By the end of this lesson, you'll have stationary turrets that detect when the player comes near and shoot projectiles toward the player's current position. The turrets will wait between shots, making them challenging but fair enemies!

## Today's New Programming Concept
**Target Detection and Timers** - Games need enemies that can "see" the player and react intelligently. We'll learn how to detect targets within range and use timers to control when actions happen.

## Part 1: Understanding the Code

### Step 1: Look at What We Need
To make turrets work, we need:
- A way to detect when the player is nearby
- A way to calculate which direction to shoot
- A timer system to control shooting frequency
- Reuse of the projectile system from Lesson 5

### Step 2: Compare Player vs Enemy Shooting
Think about the differences:

**Player Shooting:**
- Shoots when spacebar is pressed
- Shoots in the direction they're facing
- Player controls when to shoot

**Turret Shooting:**
- Shoots automatically when player is in range
- Shoots toward the player's current position
- Timer controls when to shoot

### Step 3: Understanding Detection
Turrets need to "see" the player. In Godot, we can use Area2D detection similar to coins and spikes, but instead of collision, we use it for "sight range."

## Part 2: Learning Target Detection

### How Area Detection Works for AI
Just like coins detect the player entering their area, turrets can detect when the player enters their "sight range":
```gdscript
func _on_detection_area_body_entered(body):
    # Player entered turret's sight range
    
func _on_detection_area_body_exited(body):
    # Player left turret's sight range
```

### Timer Systems
Timers let us control when things happen:
```gdscript
# Create a timer that waits 2 seconds
timer.wait_time = 2.0
timer.start()

# When timer finishes, this function gets called
func _on_timer_timeout():
    # Do something every 2 seconds
```

## Part 3: Building the Turret System

### Step 1: Implement Player Detection
Your turret needs to track whether the player is in range.

You'll need:
- A boolean variable to track if player is in sight
- Functions that respond to the player entering/leaving the detection area
- Print statements to confirm detection is working

### Step 2: Calculate Shooting Direction
When the turret wants to shoot, it needs to aim at the player's current position.

You'll need to:
- Get the turret's position
- Get the player's position
- Calculate the direction from turret to player
- Convert that direction to something the projectile can use

### Step 3: Implement Shooting Timer
Set up a timer system that makes the turret shoot at regular intervals when the player is in range.

You'll need:
- A timer that controls shooting frequency
- Logic to only shoot when player is detected
- A function that creates and fires projectiles

## Documentation Examples

### Working with Timers
To create and use timers in Godot:
```gdscript
# In _ready() function to set up the timer
func _ready():
    # Get reference to Timer node
    var shooting_timer = $ShootingTimer
    
    # Set how long to wait (in seconds)
    shooting_timer.wait_time = 2.0
    
    # Connect the timeout signal
    shooting_timer.timeout.connect(_on_shooting_timer_timeout)

# Function called when timer finishes
func _on_shooting_timer_timeout():
    print("Timer finished - do something!")
    # Timer automatically repeats if set to do so
```

### Getting Object Positions
To find where objects are located:
```gdscript
# Get current object's position
var my_position = global_position

# Get another object's position (if you have reference to it)
var target_position = target_object.global_position

# Calculate distance between two positions
var distance = my_position.distance_to(target_position)
```

### Direction Calculation
To calculate direction from one point to another:
```gdscript
# Calculate direction vector from point A to point B
var from_position = Vector2(100, 100)
var to_position = Vector2(200, 150)

var direction = (to_position - from_position).normalized()
# .normalized() makes it a unit vector (length of 1)
```

### Boolean Variables and State Tracking
To track whether something is true or false:
```gdscript
# Declare boolean variable
var player_in_range = false

# Set to true when something happens
func _on_area_entered(body):
    if body.name == "Player":
        player_in_range = true
        print("Player detected!")

# Set to false when condition changes
func _on_area_exited(body):
    if body.name == "Player":
        player_in_range = false
        print("Player lost!")

# Use in decisions
func try_to_shoot():
    if player_in_range:
        print("Shooting at player!")
    else:
        print("No target in range")
```

### Reusing Projectile Systems
To create projectiles similar to the player:
```gdscript
# Load projectile scene (same as player used)
var projectile_scene = preload("res://scenes/projectile.tscn")

# Create new projectile instance
var new_projectile = projectile_scene.instantiate()

# Set projectile position
new_projectile.global_position = global_position

# Set projectile direction (using calculated direction)
new_projectile.set_direction_vector(calculated_direction)

# Add to game world
get_parent().add_child(new_projectile)
```

## Part 4: Understanding the AI Flow

### The Turret Behavior Loop
Here's what happens every frame:
1. Turret checks if player is in detection range
2. If player is in range AND timer is ready, calculate direction to player
3. Create projectile aimed at player's current position
4. Reset timer to wait before next shot
5. Repeat

### Why This Creates Good AI
This pattern creates realistic enemy behavior:
- **Reactive** - turret only shoots when player is nearby
- **Predictable** - consistent timing lets players learn patterns
- **Fair** - timer prevents overwhelming bullet spam
- **Challenging** - aims at player's current position

## Part 5: Practice and Testing

### Test 1: Detection Range
Walk around the turret at different distances:

**Expected behavior:**
- Console messages when entering/leaving detection area
- Turret only "sees" player when in the detection area
- Detection works from all angles around turret

### Test 2: Shooting Timing
Stand in the turret's range and observe shooting:

**Expected behavior:**
- Turret shoots at regular intervals (every few seconds)
- Turret doesn't shoot when player is out of range
- Projectiles are created and move toward player position

### Test 3: Aiming Accuracy
Move around while in the turret's range:

**Expected behavior:**
- Projectiles aim toward where player was when shot was fired
- Direction calculation updates each shot
- Projectiles don't home in on player (they travel in straight lines)

## Common Problems and Solutions

### Problem: Turret shoots continuously without pause
**Solution:** Check that your timer is properly set up and connected. Make sure you're only shooting in the timer timeout function.

### Problem: Projectiles don't aim at player
**Solution:** Verify that you're calculating direction from turret position to player position, and that you're passing this direction to the projectile correctly.

### Problem: Detection doesn't work
**Solution:** Check that the Area2D signals are connected properly and that you're checking for the correct object name ("Player").

### Problem: Projectiles appear but don't move
**Solution:** Make sure your projectile script can handle direction vectors, not just string directions like "up" and "down".

## Advanced Challenge: Projectile Direction

The projectile script from Lesson 5 expects directions like "up", "down", "left", "right". For turrets, you might need to modify the projectile to also accept Vector2 directions for more precise aiming.

Consider adding a second function to your projectile:
```gdscript
func set_direction_vector(direction_vector):
    # Set direction directly as Vector2
    direction = direction_vector
```

## What We Accomplished
🎉 Excellent work! You just learned:
- **Enemy AI basics** - making objects react to player presence
- **Target detection** - using Area2D for AI sight ranges
- **Timer systems** - controlling when actions happen
- **Direction calculation** - aiming toward moving targets
- **Code reuse** - adapting projectile systems for enemies
- **Boolean state tracking** - remembering whether conditions are met

## Debugging Your Turret System

Add these print statements to understand the AI flow:

```gdscript
# In detection functions:
print("Player entered range: ", body.name)
print("Player left range: ", body.name)

# In shooting function:
print("Shooting at player position: ", player_position)
print("Turret position: ", global_position)
print("Direction calculated: ", direction)
```

This helps you see:
- When detection triggers work
- What positions are being used for calculations
- Whether direction calculation is working correctly

## Next Time Preview
In our next lesson, we'll create moving enemies with state machines! We'll learn how enemies can have different behaviors like patrolling, chasing, and attacking, and how they switch between these states based on what's happening in the game.