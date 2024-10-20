extends Node
class_name TowerHandler

static var towers_node: Node


func _ready() -> void:
	towers_node = self

# Sample Usage: create_tower("radius", "sprinkler", Vector2(100, 100))
static func create_tower(type: String, name: String, position: Vector2) -> void:
	var tower: Node = Tower.create(type, name, position)
	towers_node.add_child(tower)
