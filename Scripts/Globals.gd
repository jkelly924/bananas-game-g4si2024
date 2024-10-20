extends Node

@warning_ignore("unused_signal")
signal hpChanged(newHp, maxHp)
@warning_ignore("unused_signal")
signal goldChanged(newGold)
@warning_ignore("unused_signal")
signal waveStarted(wave_count, enemy_count)
@warning_ignore("unused_signal")
signal enemyDestroyed(remain)

var tower_information = {
	1: {
		name = "Sprinkler",
		id = "sprinkler",
		price = 80.0,
		texture = load("res://Textures/Tower/sprinkler/0.png"),
		round_unlocked = 0
	},
	2: {
		name = "Bench",
		id = "bench",
		price = 100.0,
		texture = load("res://Textures/Tower/bench/top.png"),
		round_unlocked = 2
	},
	3: {
		name = "Spikes",
		id = "spike",
		price = 100.0,
		texture = load("res://Textures/Tower/spike/3.png"),
		round_unlocked = 2
	},
	4: {
		name = "Speaker",
		id = "speaker",
		price = 200.0,
		texture = load("res://Textures/Tower/speaker/0.png"),
		round_unlocked = 3
	},
	5: {
		name = "Police (Bullets)",
		id = "bullet_cop",
		price = 200.0,
		texture = load("res://Textures/Tower/police/bullet_tower.png"),
		round_unlocked = 5
	},
}

var tower_radius_stats = {
	"sprinkler": {
		damage = 1,
		range = 2,
		cooldown = 3,
	},
	"bullets": {
		damage = 1,
		range = 2,
		cooldown = 3,
	},
	"gas": {
		damage = 1,
		range = 2,
		cooldown = 3,
	}
}

var money: int = 100
var health: int = 10

func give_money(n: int) -> void:
	money += n
	goldChanged.emit()


func take_damage() -> void:
	print("YOU TOOK DAMGAE")
