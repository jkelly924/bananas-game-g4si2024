extends Node

@warning_ignore("unused_signal")
signal hpChanged(newHp, maxHp)
@warning_ignore("unused_signal")
signal goldChanged(newGold)
@warning_ignore("unused_signal")
signal waveStarted(wave_count, enemy_count)
@warning_ignore("unused_signal")
signal enemyDestroyed(remain)

var money: int = 100

func give_money(n: int) -> void:
	money += n
	goldChanged.emit()
