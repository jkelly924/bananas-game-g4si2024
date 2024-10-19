extends Node

var enemy_scene
var enemies: Node2D

@onready var spawn_timer: Timer = $SpawnTimer

var goal_max_enemies: int = 200
var sum_enemy_difficulty: int
var enemy_difficulties = {
	'Normal': 1,
	'Strong': 3,
	'Heavy': 9,
}


func delay(time: float):
	spawn_timer.wait_time = time
	spawn_timer.start()
	return await spawn_timer.timeout


func get_difficulty_score(round: int) -> int:
	return 5#int(5 * pow(1.2, round - 1))


func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	enemies.add_child(enemy)


func get_enemy_probabilities(round_number: int):
	var bias_factor: float = 1 - exp(-float(round_number) / 25)
	bias_factor *= bias_factor
	print(bias_factor)
	
	var probabilities = {}
	var total_probability: float = 0
	for enemy_type: String in enemy_difficulties:
		var this_difficulty: float = float(enemy_difficulties[enemy_type])
		# The lower the level we are at, the more likely low-level enemies are.
		# 1 / this_difficulty makes a smaller distribution for high level enemies
		# 1 / bias_factor furthers this distribution
		var low_level_weight: float = (1 / bias_factor) * (1 / this_difficulty)
		var high_level_weight: float = (1 / (1 - bias_factor)) * this_difficulty
		
		print(enemy_type)
		print(low_level_weight)
		print(high_level_weight)
		
		probabilities[enemy_type] = low_level_weight + high_level_weight
		total_probability += probabilities[enemy_type]
	
	# Normalize the probabilities
	for enemy_type: String in enemy_difficulties:
		probabilities[enemy_type] /= total_probability
	
	print(probabilities)
	
	return probabilities


func weighted_random(enemy_probabilities) -> String:
	var number: float = randf()
	var cumulative_weight: float = 0
	for enemy_type: String in enemy_probabilities:
		cumulative_weight += enemy_probabilities[enemy_type]
		if cumulative_weight >= number:
			return enemy_type
	
	# If no enemy was found (this shouldnt happen), get the last one
	return enemy_probabilities.keys().back()


func begin_round(round: int) -> void:
	var difficulty: int = get_difficulty_score(round)
	
	var enemy_probabilities = get_enemy_probabilities(round)
	
	var enemy_types = []
	while difficulty >= 1:
		var enemy_type: String = weighted_random(enemy_probabilities)
		if enemy_difficulties[enemy_type] <= difficulty:
			difficulty -= enemy_difficulties[enemy_type]
			enemy_types.append(enemy_type)
	
	print(enemy_types)
	for enemy_type: String in enemy_types:
		await delay(0.5)
		spawn_enemy()


func clean_up_round() -> void:
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for enemy: String in enemy_difficulties:
		sum_enemy_difficulty += enemy_difficulties[enemy]
	
	var root_node: Node2D = get_tree().get_root().get_node('test_level')
	enemies = root_node.get_node('Enemies')
	
	enemy_scene = preload("res://Entities/Enemy.tscn")
	
	begin_round(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
