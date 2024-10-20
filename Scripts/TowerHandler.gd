extends Node
class_name TowerHandler

static var towers_node: Node

static var slowing_towers: Array[Node]


func _ready() -> void:
	towers_node = self
	#create_tower("sprinkler", Vector2(100, 100))
	#create_tower("speaker", Vector2(150, 150))


static func create_tower(name: String, position: Vector2) -> void:
	var tower: Node = load("res://Towers/Scenes/" + name + ".tscn").instantiate()
	tower.position = position
	towers_node.add_child(tower)
	
	if name == "speaker" or name == "bench":
		slowing_towers.append(tower)
