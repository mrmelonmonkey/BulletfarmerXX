extends State
class_name IdleState

@onready var state_machine: Node = $Node2D/Player/PlayerCharacter/StateMachine
@onready var player_stats: PlayerStats = $"../.."
@onready var player_character: CharacterBody2D = $"../../PlayerCharacter"
@onready var animation_player: AnimationPlayer = $"../../PlayerCharacter/AnimationPlayer"
var last_look_dir = -1

func enter():
	if sign(player_stats.look_dir.x) < 0:
		animation_player.play("Idle_left")
	else:
		animation_player.play("Idle_right")

func exit():
	pass

func Physics_Update(delta):
	if last_look_dir != sign(player_stats.look_dir.x):
		last_look_dir = sign(player_stats.look_dir.x)
		if last_look_dir < 0:
			animation_player.play("Idle_left")
		else:
			animation_player.play("Idle_right")
	
func Update(_delta):
	if player_stats.move_vec.length() > 0:
		Transitioned.emit(self,"MoveState")
