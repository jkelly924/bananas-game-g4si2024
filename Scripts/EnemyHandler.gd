extends Node2D
class_name EnemyHandler

static var next_enemy_id_n: int = 0
static var active_enemy_ids: Array[String]
static var id_to_enemy: Dictionary = {}

static var enemies_node: Node


func _ready():
	enemies_node = self


static func create_enemy(level: int, place: int) -> Node:
	var id: String = str(next_enemy_id_n)
	var enemy: Node = Enemy.create(level, id)
	
	id_to_enemy[id] = enemy
	active_enemy_ids[place] = id
	
	next_enemy_id_n += 1
	enemies_node.add_child(enemy)
	return enemy


static func get_enemies_in_range(position: Vector2, range: float) -> Array[Node]:
	var enemies: Array[Node] = []
	for enemy_id: String in id_to_enemy:
		var node: Node = id_to_enemy[enemy_id]
		if (position - node.position).length() <= range * 144:
			enemies.append(node)
	
	return enemies


# Finds the first enemy that is the furthest down the track, still in the tower range
static func get_first_valid_enemy(position: Vector2, range: float) -> Node:
	var last_enemy_index: int = -1
	while true:
		var enemy_index: int = get_furthest_enemy_index(last_enemy_index + 1)
		var enemy: Node = get_enemy_from_index(enemy_index)
		if enemy == null:
			return null
		
		last_enemy_index = enemy_index
		if (enemy.position - position).length() < (range * 144):
			return enemy
	
	return null


static func get_enemy_from_index(index: int) -> Node:
	if index == -1:
		return null
	else:
		return id_to_enemy[active_enemy_ids[index]]


static func get_furthest_enemy_index(start: int = 0) -> int:
	for i: int in range(start, len(active_enemy_ids)):
		var enemy_id: String = active_enemy_ids[i]
		if enemy_id != "":
			return i
	
	return -1


static func register_enemy_death(id: String) -> void:
	id_to_enemy.erase(id)
	var index: int = active_enemy_ids.find(id)
	if (index != -1):
		active_enemy_ids[index] = ""
	
	var found_existing: bool = false
	for this_id: String in active_enemy_ids:
		if this_id != "":
			found_existing = true
			break
	
	if not found_existing:
		Globals.final_enemy_death.emit()


static func register_enemy_finished_path(id: String) -> void:
	Globals.take_damage()


static func on_new_round(enemy_count: int) -> void:
	id_to_enemy = {}
	active_enemy_ids = []
	active_enemy_ids.resize(enemy_count)
