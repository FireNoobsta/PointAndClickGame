extends Node2D

@onready var musicPlayer : AudioStreamPlayer = $MusicPlayer
@onready var timer := $Timer
@onready var button := $CanvasLayer/Button

const MUSIC_ARRAY = [
	preload("res://Assets/Sound/Music/song 1.wav"),
	#preload("res://Assets/Sound/Music/song 1 Piano.wav"),
	preload("res://Assets/Sound/Music/song 1 minor corrupt.wav")
	]
#const SONG_1 = preload("res://Assets/Sound/Music/song 1.wav")
#const SONG_1_PIANO = preload("res://Assets/Sound/Music/song 1 Piano.wav")

var tempIndex = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	#timer.timeout.connect(SeamlessSwitchSong)
	button.pressed.connect(SeamlessSwitchSong)

func FadeMusic(duration : float):
	var tween = get_tree().create_tween()
	tween.tween_property(musicPlayer, "volume_db", -25, duration)
	tween.tween_callback(musicPlayer.stop)

func SeamlessSwitchSong(index : int = 0):
	print("Switching songs")
	var currPos = musicPlayer.get_playback_position()
	musicPlayer.stream = MUSIC_ARRAY[tempIndex]
	musicPlayer.play(currPos)
	tempIndex = (tempIndex + 1) % MUSIC_ARRAY.size()
