# Lesson 7: Enemy States with Enums

## What We're Learning Today
- How to create and use enum types for organizing code
- How to implement basic state switching with timers
- How to organize enemy behavior into clear, separate states
- How to make enemies switch between idle and patrol behaviors

## What We're Building
By the end of this lesson, you'll have an enemy that can be in two different states: IDLE (standing still) and PATROL (moving between points). The enemy will switch between these states automatically using a timer system, creating the foundation for more complex AI behavior.

## Today's New Programming Concept
**Enums and Basic State Management** - Enums let us create named constants that make our code easier to read and understand. Instead of using confusing numbers (0, 1, 2), we can use clear names (IDLE, PATROL, CHASE) to represent different enemy behaviors.

## Part 1: Understanding the Code

### Step 1: Look at What We Need
To make basic state enemies work, we need:
- Two different states (IDLE and PATROL)
- A way to track which state the enemy is currently in
- Different behavior for each state
- A timer system to switch between states

### Step 2: Compare Static vs Dynamic Behavior

**Static Enemy (like spikes):**
- Always does the same thing
- No changing behavior

**State-Based Enemy (This Lesson):**
- Can do different things at different times
- Remembers what it's currently doing
- Changes behavior based on internal timers

### Step 3: Real-World State Examples
Think about how a traffic light works:
- **RED**: Cars must stop (one behavior)
- **GREEN**: Cars can go (different behavior)  
- **YELLOW**: Cars should prepare to stop (third behavior)

The light is always in one state, and it switches between them based on timers. Our enemy will work the same way!

## Part 2: Learning Enums and Basic States

### Why Do We Need Enums?
Imagine trying to remember what different numbers mean:
- Is the enemy in state 0, 1, or 2?
- What does state 1 do again?
- Did I use 2 for PATROL or CHASE?

Enums solve this by letting us use names instead of numbers!

### How States Work
Think of your enemy as having a "job description" that can change:
- **Current Job**: What the enemy is doing right now
- **Job Rules**: What to do while doing that job
- **Job Changes**: When to switch to a different job

The enemy always has exactly one job (state) at any time.

### Timer-Based State Changes
For this lesson, we'll use simple timers:
- Enemy stays IDLE for 3 seconds
- Then switches to PATROL for 5 seconds  
- Then back to IDLE for 3 seconds
- Repeats forever

This creates a predictable but dynamic behavior pattern.

## Part 3: Building Your State-Based Enemy

### Your Challenge
You need to create an enemy that can switch between IDLE and PATROL states using timers. The enemy should:
- Stand still when IDLE
- Move between two points when PATROL  
- Switch states automatically based on time
- Print which state it's in for debugging

### What You Need to Figure Out
1. How to create an enum with two states
2. How to track which state the enemy is currently in
3. How to make different things happen in each state
4. How to use timers to switch between states
5. How to make the enemy move between patrol points

### Think About These Questions
- Where will you store the current state?
- How will you make the enemy do different things in each state?
- What should happen when the timer runs out?
- How can you make patrol movement work smoothly?

## Documentation Examples

### Understanding Enums
Enums create a set of named constants that represent related values:

```gdscript
# Example: Traffic Light States  
enum TrafficLight {
    RED,
    YELLOW, 
    GREEN
}

# Example: Game Menu States
enum MenuState {
    MAIN_MENU,
    SETTINGS,
    PLAYING,
    PAUSED
}

# Example: Player Actions
enum PlayerAction {
    STANDING,
    WALKING,
    JUMPING,
    ATTACKING
}
```

### Using Enum Values
Once you create an enum, you can use it like this:

```gdscript
# Create a variable that holds an enum value
var light_state = TrafficLight.RED
var menu_state = MenuState.MAIN_MENU

# Check what value it currently has
if light_state == TrafficLight.RED:
    print("Stop!")
elif light_state == TrafficLight.GREEN:
    print("Go!")

# Change the value
light_state = TrafficLight.GREEN
menu_state = MenuState.PLAYING
```

### Timer-Based Behavior
To make things happen after a certain amount of time:

```gdscript
# Example: Simple timer variable
var time_passed = 0.0
var switch_time = 3.0

func _process(delta):
    time_passed += delta
    
    if time_passed >= switch_time:
        print("Time to do something!")
        time_passed = 0.0  # Reset timer

# Example: Different timing for different states  
var idle_duration = 2.0
var patrol_duration = 4.0

# Example: Using Godot's Timer node
func _ready():
    var timer = $Timer
    timer.wait_time = 3.0
    timer.timeout.connect(_on_timer_finished)
    timer.start()

func _on_timer_finished():
    print("Timer finished!")
```

### Organizing State Behavior
To do different things based on current state:

```gdscript
# Example: Traffic light behavior
func _process(delta):
    if current_state == TrafficLight.RED:
        # Red light behavior
        stop_traffic()
    elif current_state == TrafficLight.GREEN:
        # Green light behavior  
        allow_traffic()
    elif current_state == TrafficLight.YELLOW:
        # Yellow light behavior
        warn_traffic()

# Example: Using match statements (cleaner for many states)
func _process(delta):
    match current_state:
        TrafficLight.RED:
            stop_traffic()
        TrafficLight.GREEN:
            allow_traffic()
        TrafficLight.YELLOW:
            warn_traffic()

# Example: Separate functions for each state
func handle_red_state():
    print("Red light is on")
    # Red light logic here

func handle_green_state():
    print("Green light is on")  
    # Green light logic here
```

### Moving Between Points
To make objects move from one location to another:

```gdscript
# Example: Moving toward a target position
func move_toward_point(target_position, move_speed, delta):
    # Calculate direction from current position to target
    var direction = (target_position - global_position).normalized()
    
    # Move in that direction
    global_position += direction * move_speed * delta
    
    # Check if we're close enough to the target
    var distance = global_position.distance_to(target_position)
    if distance < 5.0:  # Close enough
        return true
    else:
        return false

# Example: Working with arrays of positions
var point_list = [Vector2(100, 100), Vector2(200, 100), Vector2(200, 200)]
var current_point_index = 0

func get_current_target():
    return point_list[current_point_index]

func go_to_next_point():
    current_point_index += 1
    if current_point_index >= point_list.size():
        current_point_index = 0  # Go back to first point
```

## Part 4: Connecting the Dots

### Your Implementation Strategy
1. **Start with the enum** - Create two states: IDLE and PATROL
2. **Add state tracking** - Create a variable to remember current state  
3. **Set up timers** - Use either delta time or Timer nodes
4. **Create state behaviors** - Different actions for IDLE vs PATROL
5. **Test each piece** - Print debug messages to see state changes

### Questions to Guide Your Thinking
- How will you know when to switch from IDLE to PATROL?
- What should the enemy do while in IDLE state?
- How will you make the enemy move between two points during PATROL?
- Where will you put the logic that checks if it's time to switch states?
- How can you debug and see which state the enemy is currently in?

## Part 5: Testing Your State System

### What Success Looks Like
When your enemy is working correctly, you should see:
- Enemy stands still for a few seconds (IDLE)
- Enemy moves between two points for a few seconds (PATROL)  
- Clear print statements showing which state it's in
- Smooth transitions between states based on your timer
- Enemy repeats this pattern continuously

### Common Challenges You'll Face
- **Enum syntax**: Getting the enum declaration correct
- **State switching**: Remembering to actually change the state variable
- **Timer logic**: Making sure your timer resets properly
- **Movement**: Getting smooth movement between patrol points
- **Debugging**: Adding enough print statements to see what's happening

## What You'll Accomplish
🎉 By completing this lesson, you'll have learned:
- **Enum creation and usage** - organizing related constants with clear names
- **Basic state management** - tracking what an object is currently doing  
- **Timer-based logic** - making things happen after certain time periods
- **Conditional behavior** - doing different things based on current state
- **Foundation for complex AI** - the building blocks for smarter enemies

This lesson creates the groundwork for more advanced AI behavior in future lessons!

## Next Time Preview
In our next lesson, we'll add distance-based behavior to our state machine! We'll learn how to make enemies detect the player and switch to a CHASE state, building on the enum foundation you've created in this lesson.