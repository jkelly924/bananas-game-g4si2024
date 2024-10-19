extends Control

#var next_wait_time := 0
#var waited := 0
#var open_details_pane : PanelContainer

func _ready():
	Globals.hpChanged.connect(update_hp)
	Globals.goldChanged.connect(update_gold)
	Globals.waveStarted.connect(show_wave_count)
	Globals.enemyDestroyed.connect(update_enemy_count)

func update_hp(newHp, maxHp):
	%HPLabel.text = "HP: " + str(round(newHp)) + "/" + str(round(maxHp))

func update_gold(newGold):
	%GoldLabel.text = "Gold: " + str(round(newGold))

func show_wave_count(current_wave, enemies):
	%WaveLabel.text = "Current Wave: " + str(current_wave)
	%RemainLabel.text = "Enemies: " + str(enemies)
	%RemainLabel.visible = true

func update_enemy_count(remain):
	%RemainLabel.text = "Enemies: " + str(remain)
