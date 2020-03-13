# Base class for all players/enemies for standard member variables/functions

extends KinematicBody2D

class_name CharacterActor

const DEFAULT_MAX_HEALTH = 20

# Define a maximum and starting health for each actor
export var max_health = DEFAULT_MAX_HEALTH
export var start_health = DEFAULT_MAX_HEALTH

# When the scene is ready, the actor's health should be set to the starting health
onready var health = start_health

# Define a velocity vector for movement
var velocity : Vector2 = Vector2(0, 0)

# Boolean for indicating direction of movement
var face_r : bool = true

# State variables for driving any internal state machine
var state : String = "idle"
var prev_state = ["idle", "idle", "idle"]
var state_ref : String = "idle" # Used whenever an arbitrary state reference is needed

# Boolean for indicating if currently in an invincible state
var invincible : bool = false


func _ready():
	add_to_group("actors")


# Checks if prev_state[] contains the indicated state
func prev_state_equals(prev_state_x : String) -> bool:
	for i in prev_state_x:
		if prev_state_x == i:
			return true
	
	return false


# Moves all items in prev_state[] back by one and inserts new state at beginning
func set_prev_state(new_state : String) -> void:
	# Move back all items
	for i in range(prev_state.size() - 1, 0, -1):
		prev_state[i] = prev_state[i - 1]
	
	# Add new state at beginning
	prev_state[0] = new_state


func apply_gravity(delta_var : float, gravity_vector : float = Global.GRAVITY) -> void:
	velocity.y += (Global.GRAVITY * delta_var)
