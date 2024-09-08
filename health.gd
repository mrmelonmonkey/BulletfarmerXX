extends Node

var health = 100
var parent

func _process(delta: float) -> void:
	parent = get_parent()
	
