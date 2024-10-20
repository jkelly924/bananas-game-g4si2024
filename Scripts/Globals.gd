extends Node

signal health_changed(health: int)
signal budget_changed(new_budget: int)
signal waveStarted(wave_count, enemy_count)
signal enemyDestroyed(remain)

signal game_over()
signal game_won()

signal final_enemy_death()

var tower_information = [
	{
		name = "Sprinkler",
		id = "sprinkler",
		price = 80.0,
		texture = load("res://Textures/Tower/sprinkler/0.png"),
		round_unlocked = 0
	},
	{
		name = "Bench",
		id = "bench",
		price = 100.0,
		texture = load("res://Textures/Tower/bench/top.png"),
		round_unlocked = 2
	},
	{
		name = "Spikes",
		id = "spike",
		price = 100.0,
		texture = load("res://Textures/Tower/spike/3.png"),
		round_unlocked = 2
	},
	{
		name = "Speaker",
		id = "speaker",
		price = 200.0,
		texture = load("res://Textures/Tower/speaker/0.png"),
		round_unlocked = 3
	},
	{
		name = "Police (Bullets)",
		id = "bullet_cop",
		price = 200.0,
		texture = load("res://Textures/Tower/police/bullet_tower.png"),
		round_unlocked = 5
	},
	{
		name = "Tear Gas",
		id = "gas_cop",
		price = 200.0,
		texture = load("res://Textures/Tower/police/gas_tower.png"),
		round_unlocked = 6,
	},
	{
		name = "Tent",
		id = "tent",
		price = 100.0,
		texture = load("res://Textures/Tower/tent.png"),
		round_unlocked = 8,
	},
	{
		name = "Shelter",
		id = "shelter",
		price = 100.0,
		texture = load("res://Textures/Tower/shelter.png"),
		round_unlocked = 1,
	},
	{
		name = "Food Bank",
		id = "food_bank",
		price = 100.0,
		texture = load("res://Textures/Tower/food_bank.png"),
		round_unlocked = 1,
	},
	{
		name = "Houses",
		id = "houses",
		price = 100.0,
		texture = load("res://Textures/Tower/houses.png"),
		round_unlocked = 1,
	}
]

var budget: int = 100
var health: int = 10


func _ready():
	game_won.connect(_on_game_won)
	game_over.connect(_on_game_over)


func _on_game_over():
	get_tree().change_scene_to_file("res://Levels/lose_screen.tscn")


func _on_game_won():
	get_tree().change_scene_to_file("res://Levels/win_screen.tscn")


func award_budget(n: int) -> void:
	budget += n
	budget_changed.emit(budget)
	SoundHandler.play_gain_money_sound()


func take_damage() -> void:
	health -= 1
	health_changed.emit(health)
	
	if health <= 0:
		game_over.emit()
	else:
		SoundHandler.play_hurt_sound()
