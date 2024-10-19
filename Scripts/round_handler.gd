extends Node

var enemy_scene
var enemies: Node2D

@onready var spawn_timer: Timer = $SpawnTimer

var sum_enemy_difficulty: int
var enemy_difficulties: Array[int] = [1, 2, 4]

func delay(time: float):
	spawn_timer.wait_time = time
	spawn_timer.start()
	return await spawn_timer.timeout


func get_difficulty_score(round: int) -> int:
	return min(int(6 * pow(1.15, round - 1)), 120) # No more than 120 enemies can be spawned


func spawn_enemy(level: int) -> void:
	var enemy = enemy_scene.instantiate()
	enemy.starting_level = level
	enemies.add_child(enemy)


func get_enemy_probabilities(round_number: int) -> Array[float]:
	var bias_factor: float = 1 - exp(-float(round_number) / 25)
	
	var probabilities: Array[float] = Array([], TYPE_FLOAT, "", null)
	probabilities.resize(enemy_difficulties.size())
	
	var total_probability: float = 0
	var cumulative_difficulty: float = 0
	for enemy_level: int in enemy_difficulties.size():
		var this_difficulty: float = float(enemy_difficulties[enemy_level])
		cumulative_difficulty += this_difficulty
		
		var dist = abs(cumulative_difficulty / sum_enemy_difficulty - bias_factor)
		var low_level_weight: float = (1 / bias_factor) * pow(1 / dist, 2)
		var high_level_weight: float = (1 / (1 - bias_factor)) * pow(dist, 2)

		probabilities[enemy_level] = low_level_weight + high_level_weight
		total_probability += probabilities[enemy_level]
	
	# Normalize the probabilities
	for enemy_level: int in enemy_difficulties.size():
		probabilities[enemy_level] /= total_probability
	
	print(probabilities)
	return probabilities


func weighted_random(enemy_probabilities: Array[float]) -> int:
	var number: float = randf()
	var cumulative_weight: float = 0
	for enemy_level: int in enemy_probabilities.size():
		cumulative_weight += enemy_probabilities[enemy_level]
		if cumulative_weight >= number:
			return enemy_level
	
	# This should ideally never be reached, but oh well
	return 0


func begin_round(round: int) -> void:
	print("Beginning Wave: ", round)
	var difficulty: int = get_difficulty_score(round)
	
	var enemy_counts: Array[int]= Array([], TYPE_INT, "", null)
	enemy_counts.resize(enemy_difficulties.size())
	
	var enemy_probabilities: Array[float] = get_enemy_probabilities(round)
	while difficulty >= 1:
		var enemy_level: int = weighted_random(enemy_probabilities)
		if enemy_difficulties[enemy_level] <= difficulty:
			difficulty -= enemy_difficulties[enemy_level]
			enemy_counts[enemy_level] += 1
	
	print(enemy_counts)
	for enemy_level: int in enemy_counts.size():
		for i: int in range(enemy_counts[enemy_level]):
			await delay(0.5)
			spawn_enemy(enemy_level)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for enemy_level: int in enemy_difficulties.size():
		sum_enemy_difficulty += enemy_difficulties[enemy_level]
	
	var root_node: Node2D = get_tree().get_root().get_node('test_level')
	enemies = root_node.get_node('Enemies')
	
	enemy_scene = preload("res://Entities/Enemy.tscn")
	
	begin_round(1)
