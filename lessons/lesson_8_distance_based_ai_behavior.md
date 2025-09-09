# Lesson 8: Distance-Based AI Behavior

## What We're Learning Today
- How to calculate distances between objects in your game
- How to make decisions based on how far away things are
- How to add a CHASE state that activates when player gets close
- How to combine timer-based and distance-based state switching

## What We're Building
Building on your IDLE/PATROL enemy from Lesson 7, you'll add intelligent player detection! When the player gets too close, your enemy will switch to a CHASE state and pursue them. When the player gets far enough away, the enemy returns to patrolling.

## Today's New Programming Concept
**Distance-Based Decision Making** - Instead of only using timers to change behavior, we can make enemies react to what's happening in the game world. Distance calculations let us create enemies that feel aware and responsive to the player's actions.

## Part 1: Understanding the Challenge

### Step 1: What We're Adding
To your existing IDLE/PATROL enemy, we're adding:
- A new CHASE state
- Player detection based on distance
- State switching based on proximity
- Combining multiple decision factors (time AND distance)

### Step 2: Real-World Examples
Think about how a guard dog behaves:
- **Normal times**: Sleeps or walks around its territory (IDLE/PATROL)
- **Stranger approaches**: Becomes alert and chases the intruder (CHASE)  
- **Stranger leaves**: Eventually returns to normal routine (back to PATROL)

The dog makes decisions based on how close the person is!

### Step 3: State Transition Logic
Your enemy will now have more complex decision making:
- **IDLE → PATROL**: Timer expires (like before)
- **PATROL → CHASE**: Player gets too close (NEW!)
- **CHASE → PATROL**: Player gets far away (NEW!)
- **CHASE → IDLE**: Player disappears for a long time (bonus challenge)

## Part 2: Learning Distance Calculations

### Why Distance Matters in Games
Distance calculations help create:
- **Realistic AI behavior** - enemies that notice nearby threats
- **Performance optimization** - only do expensive calculations when needed  
- **Game balance** - players can avoid enemies by staying far away
- **Immersive experiences** - enemies that feel alive and aware

### Understanding Game Space
In Godot, every object has a position in 2D space:
- Position is stored as Vector2 (x, y coordinates)  
- Distance between two points can be calculated
- We can use distance to trigger different behaviors
- Closer objects have smaller distance values

## Part 3: Building Distance-Aware AI

### Your Challenge
Extend your IDLE/PATROL enemy to:
- Detect when the player is within "chase range"
- Switch to CHASE state and pursue the player
- Return to PATROL when player escapes to "safe distance"
- Handle the transition smoothly without getting stuck

### What You Need to Figure Out
1. How to get references to both enemy and player positions
2. How to calculate the distance between them
3. What distance values make sense for your game
4. How to modify your state switching logic
5. How to make the enemy move toward the player during CHASE

### Design Questions to Consider
- How close should the player get before the enemy notices?
- Should the "stop chasing" distance be the same as "start chasing"?
- What should the enemy do while in CHASE state?
- How fast should the enemy move when chasing vs. patrolling?

## Documentation Examples

### Working with Object Positions
To find where objects are located in your game world:

```gdscript
# Getting position of the current object
var my_position = global_position

# Getting position of another object (if you have a reference)
var target_position = some_object.global_position

# Positions are Vector2 values with x and y components
print("My position: ", my_position.x, ", ", my_position.y)
```

### Distance Calculations
To measure how far apart two objects are:

```gdscript
# Calculate distance between two positions
var position_a = Vector2(100, 100)
var position_b = Vector2(200, 150)

var distance = position_a.distance_to(position_b)
print("Distance: ", distance)

# Compare distances for decision making
if distance < 50:
    print("Very close!")
elif distance < 100:
    print("Nearby")
else:
    print("Far away")

# You can also calculate without storing positions
var direct_distance = global_position.distance_to(player.global_position)
```

### Getting References to Other Objects
To access other objects in your scene:

```gdscript
# Method 1: Using get_node() with the node path
var player = get_node("../Player")
var player = get_node("/root/Main/Player")

# Method 2: Finding by group (if objects are in groups)
var players = get_tree().get_nodes_in_group("player")
if players.size() > 0:
    var player = players[0]

# Method 3: Storing reference when objects are created
var player_reference  # Set this when the enemy is created

# Always check if reference is valid before using
if player_reference != null:
    var distance = global_position.distance_to(player_reference.global_position)
```

### Range-Based Behavior
To create different behavior at different distances:

```gdscript
# Example: Different behaviors based on distance ranges
var distance_to_target = global_position.distance_to(target.global_position)

if distance_to_target < 30:
    print("Attack range!")
elif distance_to_target < 100:
    print("Chase range!")
elif distance_to_target < 200:
    print("Detection range!")
else:
    print("Safe range - can't see target")

# Example: Using different distance thresholds for entering vs leaving states
var chase_start_distance = 80
var chase_stop_distance = 120  # Larger to prevent flickering

if current_state == State.PATROL and distance < chase_start_distance:
    current_state = State.CHASE
elif current_state == State.CHASE and distance > chase_stop_distance:
    current_state = State.PATROL
```

### Moving Toward Targets
To make objects move toward other objects:

```gdscript
# Calculate direction from current position to target
var target_pos = target.global_position
var direction = (target_pos - global_position).normalized()

# Move in that direction at specified speed
var move_speed = 100
global_position += direction * move_speed * delta

# Alternative: Set velocity for physics bodies
velocity = direction * move_speed
move_and_slide()

# Check if close enough to target
if global_position.distance_to(target_pos) < 10:
    print("Reached target!")
```

### Combining Multiple Conditions
To make decisions based on multiple factors:

```gdscript
# Example: State switching with multiple conditions
var distance_to_player = global_position.distance_to(player.global_position)
var time_in_current_state = current_state_timer

match current_state:
    State.IDLE:
        if time_in_current_state > idle_duration:
            current_state = State.PATROL
            
    State.PATROL:
        if distance_to_player < chase_distance:
            current_state = State.CHASE
        elif time_in_current_state > patrol_duration:
            current_state = State.IDLE
            
    State.CHASE:
        if distance_to_player > lose_target_distance:
            current_state = State.PATROL
```

## Part 4: Connecting the Dots

### Your Implementation Strategy
1. **Extend your enum** - Add CHASE to your existing IDLE/PATROL states
2. **Get player reference** - Find a way to access the player object
3. **Add distance checking** - Calculate distance in your update loop
4. **Modify state logic** - Update your state switching to consider distance
5. **Implement chase behavior** - Make enemy move toward player during CHASE
6. **Test and tune** - Adjust distance values until it feels right

### Questions to Guide Your Implementation
- Where will you store the reference to the player object?
- What distance values feel right for chase start/stop?
- How will you prevent the enemy from rapidly switching between CHASE and PATROL?
- Should the enemy move faster when chasing than when patrolling?
- How will you debug and see the distance values and state changes?

### Common Design Challenges
- **Flickering states**: Enemy rapidly switches between CHASE and PATROL
- **Lost references**: Can't find the player object to calculate distance
- **Poor performance**: Calculating distance every frame for many enemies
- **Unrealistic behavior**: Enemy chases from too far away or gives up too quickly
- **Stuck enemies**: Enemy stops moving during state transitions

## Part 5: Testing Your Smart Enemy

### What Success Looks Like
When your distance-aware enemy is working correctly:
- Enemy patrols normally when player is far away
- Enemy detects player approaching and switches to CHASE
- Enemy pursues player smoothly during CHASE state
- Enemy returns to PATROL when player escapes
- No rapid flickering between states
- Clear debug output showing state changes and distance values

### Behavior You Should Observe
1. **Patrol Phase**: Enemy moves between points, ignoring distant player
2. **Detection**: When player approaches, enemy stops patrolling and starts chasing
3. **Chase Phase**: Enemy follows player around the level
4. **Escape**: When player gets far enough away, enemy returns to patrol route
5. **Repeat**: Cycle continues as player moves in and out of range

## What You'll Accomplish
🎉 By completing this lesson, you'll have learned:
- **Distance calculations** - measuring how far apart objects are
- **Multi-factor decision making** - using both time and distance for AI choices
- **Object references** - accessing other objects in your scene
- **Responsive AI behavior** - enemies that react to player actions
- **State machine expansion** - adding new states to existing systems

This creates much more engaging and lifelike enemy behavior!

## Next Time Preview
In our final lesson of this series, we'll add an ATTACK state and complete the enemy AI system! You'll learn how to make enemies deal damage when they get close enough, creating a complete patrol → chase → attack → return cycle.