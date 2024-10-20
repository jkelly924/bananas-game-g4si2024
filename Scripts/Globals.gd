extends Node

@warning_ignore("unused_signal")
signal hpChanged(newHp, maxHp)
@warning_ignore("unused_signal")
signal budget_changed(newGold)
@warning_ignore("unused_signal")
signal waveStarted(wave_count, enemy_count)
@warning_ignore("unused_signal")
signal enemyDestroyed(remain)

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

func award_budget(n: int) -> void:
	budget += n
	budget_changed.emit()


func take_damage() -> void:
	print("YOU TOOK DAMGAE")
