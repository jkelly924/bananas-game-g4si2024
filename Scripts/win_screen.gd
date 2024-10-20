extends CanvasLayer

@onready var replay_button: Button = $replay_button
@onready var exit_button: Button = $exit_button

func _ready() -> void:
	replay_button.connect("pressed", _on_replay_button_pressed.bind())
	exit_button.connect("pressed", _on_exit_button_pressed.bind())


func _on_replay_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/test_level.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
