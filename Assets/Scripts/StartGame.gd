extends Button

@onready var music : AudioStreamPlayer = $"../../MusicPlayer"
@onready var fadeRect : ColorRect= $"../ColorRect"
@onready var timer := $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(ChangeScene)
	fadeRect.hide()

func ChangeScene():
	var tween = get_tree().create_tween()
	tween.tween_property(music, "volume_db", -25, 1)
	fadeRect.show()
	tween.tween_property(fadeRect, "color", Color(0, 0, 0, 1.0), 1)
	#tween.tween_property(self, "modulate", Color.RED, 1)
	tween.tween_callback(get_tree().change_scene_to_file.bind("res://Assets/Scenes/Game.tscn"))
	#get_tree().change_scene_to_file("res://Assets/Scenes/Game.tscn")
	
