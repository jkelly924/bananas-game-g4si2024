extends CanvasLayer

@onready var label: Label = $Label

func _ready() -> void:
	label.visible = true
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://Levels/test_level.tscn")
