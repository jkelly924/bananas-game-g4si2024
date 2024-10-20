extends Node
class_name TowerHandler

static var towers_node: Node

static var slowing_towers: Array[Node]


func _ready() -> void:
	towers_node = self
	create_tower("Radius", "sprinkler", Vector2(100, 100))


# Sample Usage: create_tower("radius", "sprinkler", Vector2(100, 100))
static func create_tower(type: String, name: String, position: Vector2) -> void:
	var tower: Node = Tower.create(type, name, position)
	towers_node.add_child(tower)
	
	if type == "slowing":
		slowing_towers.append(tower)
