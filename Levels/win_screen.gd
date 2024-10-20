extends CanvasLayer

@onready var replay_button: Button = $replayButton

func _on_replay_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/test_level.tscn")
	print("uhh")
