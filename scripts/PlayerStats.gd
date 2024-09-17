extends Node

class_name PlayerStats

signal health_updated(new_health)
signal health_depleted()

var modifiers = {}

var level : int
var experience : int
var max_health : set = set_max_health
var health : int
var speed : int


var run_mod = 1.5
var _move_dir : Vector2
var move_dir : Vector2
var move_vec = Vector2(0,0)
var drag = 0.2

var mouse_coords : Vector2
var look_dir : Vector2
@onready var player_character: CharacterBody2D = $PlayerCharacter
@export var starting_stats: StartingStats

func _ready():
	initialize(starting_stats)

func initialize(stats : StartingStats):
	level = stats.level
	experience = stats.experience
	max_health = stats.max_health
	health = stats.health
	speed = stats.speed

func set_max_health(value:int):
	max_health = max(0,value)

func take_damage(hit):
	health -= hit.damage
	health = max(0, health)
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("health_depleted")

func move():
	player_character.position += move_vec 
	
func _physics_process(delta: float) -> void:
	mouse_coords = player_character.get_global_mouse_position()
	look_dir = mouse_coords - player_character.position
	move_vec *= drag
	_move_dir = Vector2.ZERO
	_move_dir.y += -Input.get_action_strength("move_up")
	_move_dir.y += Input.get_action_strength("move_down")
	_move_dir.x += -Input.get_action_strength("move_left")
	_move_dir.x += Input.get_action_strength("move_right")
	
	move_dir = _move_dir.normalized()
	
	if Input.is_action_pressed("run"):
		move_vec += move_dir * delta * speed * run_mod
	else: move_vec += move_dir * delta * speed
	
	move()
