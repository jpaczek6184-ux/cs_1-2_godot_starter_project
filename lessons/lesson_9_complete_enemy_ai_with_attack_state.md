# Lesson 9: Complete Enemy AI with Attack State

## What We're Learning Today
- How to add an ATTACK state that deals damage to the player
- How to integrate multiple systems (AI states + player health + combat)
- How to create complete enemy behavior cycles
- How to balance AI timing and player experience

## What We're Building
You'll complete your enemy AI by adding an ATTACK state! When your enemy gets very close to the player during CHASE, it will switch to ATTACK mode, deal damage to the player, then return to chasing. This creates a complete AI cycle: IDLE → PATROL → CHASE → ATTACK → back to CHASE or PATROL.

## Today's New Programming Concept
**System Integration** - Real games combine multiple systems together. Your enemy AI will now work with the player's health system from Lesson 4, creating interactions between different parts of your game code.

## Part 1: Understanding Complete AI Behavior

### Step 1: What We're Completing
Your enemy will now have a full behavior cycle:
- **IDLE**: Resting and looking around
- **PATROL**: Moving between points when no threats detected
- **CHASE**: Pursuing the player when they get too close
- **ATTACK**: Dealing damage when right next to the player

### Step 2: Real-World AI Examples
Think about how a guard in a video game behaves:
- **Patrolling**: Walks a route, unaware of player
- **Suspicious**: Notices something and investigates  
- **Alert**: Spots player and gives chase
- **Combat**: Attacks when close enough to fight
- **Search**: Looks around when player escapes, then returns to patrol

### Step 3: Understanding Attack Behavior
The ATTACK state is different from other states:
- **Very short range** - only triggers when extremely close
- **Brief duration** - attacks quickly then returns to chase
- **System interaction** - calls the player's damage function
- **Combat timing** - needs delays to prevent instant death

## Part 2: Learning System Integration

### Why Systems Need to Work Together
In real games, different systems interact:
- **AI system** decides when to attack
- **Combat system** handles damage calculations
- **Health system** tracks player condition
- **UI system** shows health changes
- **Animation system** plays attack effects

### Design Considerations for Attack State
- **Range**: How close is "attack range"?
- **Damage**: How much damage should enemies deal?
- **Timing**: How often can enemies attack?
- **Feedback**: How does the player know they're being attacked?
- **Recovery**: What happens after an attack?

### Preventing Player Frustration
Good attack AI should:
- **Telegraph attacks** - give player warning
- **Have reasonable timing** - not attack too frequently  
- **Allow counterplay** - player can dodge or fight back
- **Provide feedback** - clear indication of damage taken

## Part 3: Building the Complete AI

### Your Challenge
Add the final piece to your enemy AI:
- Create an ATTACK state that activates at very close range
- Make the enemy deal damage to the player during attacks
- Add proper timing so attacks aren't overwhelming
- Create smooth transitions between CHASE and ATTACK
- Ensure the enemy returns to appropriate states after attacking

### What You Need to Figure Out
1. How to detect when the player is in "attack range" (even closer than chase range)
2. How to call the player's damage function from the enemy
3. How to add timing delays between attacks
4. How to handle state transitions with three distance ranges
5. How to provide feedback that an attack happened

### Advanced Design Questions
- Should enemies attack continuously or have cooldown periods?
- What happens if the player dies during an attack?
- Should different enemies deal different amounts of damage?
- How can you make attacks feel impactful but fair?

## Documentation Examples

### Multiple Distance Ranges
To create different behaviors at different distances:

```gdscript
# Example: Three different distance ranges
var attack_range = 25
var chase_range = 80  
var detection_range = 150

var distance = global_position.distance_to(player.global_position)

if distance < attack_range:
    print("Attack range - very close!")
elif distance < chase_range:
    print("Chase range - close enough to pursue")
elif distance < detection_range:
    print("Detection range - can see player")
else:
    print("Safe range - no threat detected")
```

### Calling Functions on Other Objects
To make one object affect another object:

```gdscript
# Example: Calling a function on another object
if other_object != null:
    other_object.some_function()
    other_object.some_function_with_parameter(10)

# Example: Dealing damage to player
if player_reference != null:
    player_reference.change_health(-damage_amount)

# Always check if object exists before calling functions
if target != null and target.has_method("take_damage"):
    target.take_damage(attack_damage)
```

### Attack Timing and Cooldowns
To control how often actions can happen:

```gdscript
# Example: Simple cooldown system
var last_attack_time = 0.0
var attack_cooldown = 1.5  # 1.5 seconds between attacks

func try_to_attack():
    var current_time = Time.get_unix_time_from_system()
    
    if current_time - last_attack_time > attack_cooldown:
        perform_attack()
        last_attack_time = current_time
    else:
        print("Attack on cooldown")

# Example: Using delta time for cooldowns  
var attack_timer = 0.0
var attack_delay = 2.0

func _process(delta):
    attack_timer += delta
    
    if can_attack and attack_timer >= attack_delay:
        perform_attack()
        attack_timer = 0.0  # Reset timer
```

### Complex State Switching
To handle multiple conditions for state changes:

```gdscript
# Example: Multiple distance thresholds
func update_state_based_on_distance():
    var distance = get_distance_to_player()
    
    match current_state:
        State.PATROL:
            if distance < chase_range:
                change_state(State.CHASE)
                
        State.CHASE:
            if distance < attack_range:
                change_state(State.ATTACK)
            elif distance > lose_target_range:
                change_state(State.PATROL)
                
        State.ATTACK:
            if distance > attack_range:
                change_state(State.CHASE)

# Example: Preventing rapid state switching
var state_change_cooldown = 0.5
var last_state_change_time = 0.0

func change_state(new_state):
    var current_time = Time.get_unix_time_from_system()
    
    if current_time - last_state_change_time > state_change_cooldown:
        print("Changing state from ", current_state, " to ", new_state)
        current_state = new_state
        last_state_change_time = current_time
```

### Attack Implementation Patterns
To create attack behaviors:

```gdscript
# Example: Simple attack pattern
func handle_attack_state(delta):
    # Stay in place and attack
    velocity = Vector2.ZERO
    
    # Try to attack if cooldown is ready
    if can_attack():
        perform_attack()
    
    # Check if player moved away
    if get_distance_to_player() > attack_range:
        change_state(State.CHASE)

func perform_attack():
    print("Enemy attacks!")
    
    # Deal damage to player
    if player_reference != null:
        player_reference.change_health(-attack_damage)
    
    # Start attack cooldown
    start_attack_cooldown()

# Example: Attack with animation timing
var attack_animation_duration = 0.8
var attack_state_timer = 0.0

func handle_attack_state(delta):
    attack_state_timer += delta
    
    # Start attack animation
    if attack_state_timer == 0.0:  # Just entered attack state
        play_attack_animation()
    
    # Deal damage partway through animation
    if attack_state_timer >= 0.4 and not damage_dealt:
        deal_damage_to_player()
        damage_dealt = true
    
    # Return to chase when animation finishes
    if attack_state_timer >= attack_animation_duration:
        change_state(State.CHASE)
        attack_state_timer = 0.0
        damage_dealt = false
```

### Error Prevention and Validation
To make your code robust:

```gdscript
# Example: Safe function calling
func deal_damage_to_player():
    # Check if player reference exists
    if player_reference == null:
        print("Warning: No player reference!")
        return
    
    # Check if player has the required function
    if not player_reference.has_method("change_health"):
        print("Warning: Player doesn't have change_health function!")
        return
    
    # Safe to call the function
    player_reference.change_health(-damage_amount)
    print("Dealt ", damage_amount, " damage to player")

# Example: Distance validation
func get_distance_to_player():
    if player_reference == null:
        return 999999  # Return very large distance if no player
    
    return global_position.distance_to(player_reference.global_position)
```

## Part 4: Connecting the Dots

### Your Implementation Strategy
1. **Add ATTACK state** - Extend your enum with the new state
2. **Define attack range** - Choose a very small distance for attacks
3. **Implement attack behavior** - What happens during ATTACK state
4. **Add damage dealing** - Connect to player's health system  
5. **Create attack timing** - Prevent continuous damage spam
6. **Update state transitions** - Handle three distance ranges smoothly
7. **Test and balance** - Adjust values until it feels fair and fun

### Integration Checklist
- [ ] ATTACK state added to enum
- [ ] Attack range defined (smaller than chase range)
- [ ] Attack state behavior implemented
- [ ] Player damage integration working
- [ ] Attack cooldown/timing implemented
- [ ] State transitions handle all three ranges
- [ ] Debug output shows state changes and attacks
- [ ] Player can survive and fight back

### Balancing Questions
- How much damage should enemies deal per attack?
- How long should players have to escape before being attacked?
- Should attacks have wind-up time to warn players?
- What happens when player health reaches zero?

## Part 5: Testing Your Complete AI

### What Complete Success Looks Like
Your finished enemy should demonstrate:
1. **Normal patrolling** when player is far away
2. **Player detection** and switch to chase at medium range
3. **Pursuit behavior** during chase state
4. **Attack execution** when player gets very close
5. **Damage dealing** that reduces player health
6. **State recovery** - return to chase or patrol after attack
7. **Balanced timing** - attacks feel threatening but fair

### The Complete AI Cycle
Watch for this behavior pattern:
- Enemy patrols route peacefully
- Player approaches, enemy detects and chases
- Player tries to escape but enemy follows
- Enemy gets close enough and attacks (player takes damage)
- Player escapes attack range, enemy returns to chase
- If player gets far enough away, enemy returns to patrol
- Cycle repeats as player moves around

### Performance Considerations
With complete AI, watch for:
- **Smooth state transitions** without flickering
- **Reasonable performance** even with multiple enemies
- **Predictable behavior** players can learn and counter
- **Clear feedback** when attacks occur

## What You'll Accomplish
🎉 By completing this lesson, you'll have learned:
- **Complete state machine design** - full AI behavior cycles
- **System integration** - connecting AI, combat, and health systems  
- **Attack implementation** - dealing damage from AI to player
- **Timing and balance** - making AI challenging but fair
- **Advanced state logic** - handling multiple distance ranges
- **Game feel** - creating satisfying enemy interactions

You now have a fully functional enemy AI system that rivals those found in professional games!

## Advanced Challenges

If you want to push your AI further, try adding:
- **Different enemy types** with different damage, speed, or ranges
- **Group behavior** where multiple enemies coordinate
- **Player combat** - let player fight back and defeat enemies
- **Sound effects** for state changes and attacks
- **Visual indicators** showing enemy state (angry, suspicious, etc.)

## Next Time Preview
In our next lesson, we'll create a HUD system to display player health, score, and other vital information! You'll learn how to connect your game systems to visual interface elements that give players important feedback about their progress.