extends State
class_name MoveState
@onready var player_stats: PlayerStats = $"../.."
@onready var player_character: CharacterBody2D = $"../../PlayerCharacter"
@onready var animation_player: AnimationPlayer = $"../../PlayerCharacter/AnimationPlayer"

var mouse_coord : Vector2
var drag = 0.2
var last_look_dir :int = 1
var move_dir_x : int
var move_dir = Vector2.ZERO
	
func enter():
	animation_player = player_character.find_child("AnimationPlayer")
	
func Physics_Update(delta):
	if last_look_dir != sign(player_stats.look_dir.x) or move_dir != player_stats.move_dir:
		move_dir = player_stats.move_dir
		last_look_dir = sign(player_stats.look_dir.x)
		if last_look_dir < 0:
			if sign(move_dir.x) <= 0:
				animation_player.play("Move_left")
			else:
				animation_player.play("Move_left",-1,-1,true)
		else:
			if sign(move_dir.x) >= 0:
				animation_player.play("Move_right")
			else:
				animation_player.play("Move_right",-1,-1,true)
		

func exit():
	pass

func Update(_delta):
	if player_stats.move_dir.length() < 0.2:
		Transitioned.emit(self,"IdleState")
	
