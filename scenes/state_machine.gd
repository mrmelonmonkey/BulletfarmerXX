extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary = {}
@onready var player_stats : PlayerStats = $".."
@onready var player_character : CharacterBody2D = $"../PlayerCharacter"

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		current_state = initial_state
		initial_state.enter()

func _process(delta):
	if current_state:
		current_state.Update(delta)
	else: _ready()
func _physics_process(delta: float):
	if current_state:
		current_state.Physics_Update(delta)
	else: _ready()

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state
	
	
