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

var root_node: Window
var towers_node: Node2D
var enemies_node: Node2D

func _ready():
	root_node = get_tree().get_root()
	towers_node = root_node.get_node("Towers")
	enemies_node = root_node.get_node("Enemies")

func give_money(n: int) -> void:
	money += n
	goldChanged.emit()
