extends Node2D
class_name EnemyHandler

static var next_enemy_id_n: int
static var active_enemy_ids: Array[Node2D]

static var enemies_node: Node


func _ready():
	enemies_node = get_tree().get_root().get_node("test_level").get_node("Enemies")


static func create_enemy(level: int) -> Node2D:
	var id: String = str(next_enemy_id_n)
	var enemy: Node2D = Enemy.create(level, id)
	
	next_enemy_id_n += 1
	active_enemy_ids.append(enemy)
	
	enemies_node.add_child(enemy)
	return enemy


static func get_enemy_from_index(index: int) -> Node2D:
	if index == -1:
		return null
	else:
		return active_enemy_ids[index]


static func get_furthest_enemy_index(start: int = 0) -> int:
	for i: int in range(start, active_enemy_ids.size()):
		var enemy: Node2D = active_enemy_ids[i]
		if enemy != null:
			if enemy.dead:
				active_enemy_ids[i] = null
			else:
				return i
	
	return -1


static func register_enemy_finished_path(id: String) -> void:
	Globals.take_damage()


static func on_new_round(enemy_count: int) -> void:
	active_enemy_ids = []
	active_enemy_ids.resize(enemy_count)


static func _on_child_exiting_tree(node: Node) -> void:
	var index: int = active_enemy_ids.find(node)
	if index != -1:
		active_enemy_ids[index] = null
