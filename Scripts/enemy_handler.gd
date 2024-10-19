extends Node2D

var enemies_array: Array[Node2D]


func get_enemy_from_index(index: int) -> Node2D:
	if index == -1:
		return null
	else:
		return enemies_array[index]


func get_furthest_enemy_index(start: int = 0) -> int:
	for i: int in range(start, enemies_array.size()):
		var enemy: Node2D = enemies_array[i]
		if enemy != null:
			return i
	
	return -1


func _on_child_entered_tree(node: Node) -> void:
	enemies_array.append(node)


func _on_child_exiting_tree(node: Node) -> void:
	var index: int = enemies_array.find(node)
	if index != -1:
		enemies_array[index] = null


func on_new_round(enemy_count: int) -> void:
	enemies_array = []
	enemies_array.resize(enemy_count)
