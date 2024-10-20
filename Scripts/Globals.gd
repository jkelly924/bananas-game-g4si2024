extends Node

@warning_ignore("unused_signal")
signal hpChanged(newHp, maxHp)
@warning_ignore("unused_signal")
signal goldChanged(newGold)
@warning_ignore("unused_signal")
signal waveStarted(wave_count, enemy_count)
@warning_ignore("unused_signal")
signal enemyDestroyed(remain)

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
