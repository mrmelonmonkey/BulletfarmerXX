extends CharacterBody2D

var health = 100.0
var move_acc = 200
var moveVelocity = Vector2()
var drag = 0.2
var shiftMulti = 1.1
var move_vector = Vector2(0,0)
var my_character_body
@onready var animation_player = $AnimationPlayer


func _init() -> void:
	pass

func _ready() -> void:
	animation_player.play("Idle_right")
	
func _physics_process(delta: float) -> void:
	move_vector *= drag
	var move_direction = Vector2.ZERO
	move_direction.y += -Input.get_action_strength("move_up")
	move_direction.y += Input.get_action_strength("move_down")
	move_direction.x += -Input.get_action_strength("move_left")
	move_direction.x += Input.get_action_strength("move_right")
	
	move_direction = move_direction.normalized()
	
	if move_direction.y > 0.2 or move_direction.y < -0.2:
		if move_direction.x < -0.2 :
			animation_player.play("Move_left")
		else:
			animation_player.play("Move_right")
	elif move_direction.x < -0.2:
		animation_player.play("Move_left")
	elif move_direction.x > 0.2:
		animation_player.play("Move_right")
	elif move_direction.x < 0:
		animation_player.play("Idle_left")
	else :
		animation_player.play("Idle_right")
	move_vector += move_direction * delta * move_acc
	
	global_position += move_vector
	
	
	
