extends Node
class_name TowerHandler

static var towers_node: Node

static var slowing_towers: Array[Node]

static var positive_towers: int =0


func _ready() -> void:
	towers_node = self

	create_tower("house", Vector2(150, 150))



static func create_tower(name: String, position: Vector2) -> void:
	var tower: Node = load("res://Towers/Scenes/" + name + ".tscn").instantiate()
	tower.position = position
	towers_node.add_child(tower)
	
	if name == "speaker" or name == "bench":
		slowing_towers.append(tower)
		
	if name == "house":
		positive_towers +=10;
	if name == "shelter":
		positive_towers +=5;
		
	if name == "food":
		positive_towers +=3;
	if name == "tent":
		positive_towers +=1;
		
		
