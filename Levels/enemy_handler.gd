extends Node2D


var enemies: Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_enemy_from_index(index: int) -> Node2D:
	if index == -1:
		return null
	else:
		return enemies[index]


func get_furthest_enemy_index(start: int = 0) -> int:
	for i: int in range(start, enemies.size()):
		var enemy: Node2D = enemies[i]
		if enemy != null:
			return i
	
	return -1


func _on_child_entered_tree(node: Node) -> void:
	enemies.append(node)


func _on_child_exiting_tree(node: Node) -> void:
	var index: int = enemies.find(node)
	if index != -1:
		enemies[index] = null


func on_new_round(enemy_count: int) -> void:
	enemies = []
	enemies.resize(enemy_count)
