extends Node

var parent
@onready var health_count: RichTextLabel = %HealthCount

func _process(delta: float) -> void:
	parent = get_parent()

func on_health_updated (value: int):
	health_count.text = var_to_str(value)
