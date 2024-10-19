extends Node

var enemy_scene
var enemies: Node2D

@onready var spawn_timer: Timer = $SpawnTimer


func delay(time: float):
	spawn_timer.wait_time = time
	spawn_timer.start()
	return await spawn_timer.timeout


func get_difficulty_score(round: int) -> float:
	return 10 * pow(1.2, round - 1)


func spawn_enemy() -> void:
	print('Spawning enemy')
	var enemy = enemy_scene.instantiate()
	enemies.add_child(enemy)


func begin_round(round: int) -> void:
	var difficulty: float = get_difficulty_score(round)
	for i in range(0, difficulty):
		await delay(0.5)
		spawn_enemy()


func clean_up_round() -> void:
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var root_node: Node2D = get_tree().get_root().get_node('test_level')
	
	enemies = root_node.get_node('Enemies')
	
	enemy_scene = preload("res://Entities/Enemy.tscn")
	
	begin_round(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
