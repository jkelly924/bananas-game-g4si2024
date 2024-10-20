extends Node
class_name SoundHandler

static var hurt_audio_stream_player: AudioStreamPlayer
static var game_won_audio_stream_player: AudioStreamPlayer
static var game_over_audio_stream_player: AudioStreamPlayer
static var gain_money_audio_stream_player: AudioStreamPlayer
static var background_audio_stream_player: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurt_audio_stream_player = $hurt_audio_stream_player
	game_won_audio_stream_player = $game_won_audio_stream_player
	game_over_audio_stream_player = $game_over_audio_stream_player
	gain_money_audio_stream_player = $gain_money_audio_stream_player
	background_audio_stream_player = $background_audio_stream_player
	
	background_audio_stream_player.play()
	
	Globals.game_won.connect(play_game_won_sound)
	Globals.game_over.connect(play_game_over_sound)


static func play_hurt_sound(): hurt_audio_stream_player.play()
static func play_game_won_sound(): game_won_audio_stream_player.play()
static func play_game_over_sound(): game_over_audio_stream_player.play()
static func play_gain_money_sound(): gain_money_audio_stream_player.play()
