extends CanvasLayer

@onready var exit_button: Button = $exit_button


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/MainMenu.tscn")
