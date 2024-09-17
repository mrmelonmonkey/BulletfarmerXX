extends Node

@onready var health_count: RichTextLabel = $HBoxContainer/HealthCount

func _on_player_stats_health_updated(new_health: Variant) -> void:
	health_count.text = var_to_str(new_health)
