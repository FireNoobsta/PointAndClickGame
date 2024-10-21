extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(ChangeScene)

func ChangeScene():
	get_tree().change_scene_to_file("res://Assets/Scenes/Game.tscn")
