extends Button

@export var newScene : PackedScene
@export var audioManager : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if newScene == null:
		push_error("New Scene not set for " + self.name)
	if audioManager == null:
		push_error("Audio manager not set for " + self.name)
	
	if newScene == null or audioManager == null:
		return
	
	self.pressed.connect(TransitionScene)


func TransitionScene():
	var tween = get_tree().create_tween()
	audioManager.FadeMusic(1.0)
	var gameNode = get_tree().root.get_node("Game")
	tween.tween_property(gameNode, "modulate", Color.BLACK, 1.0)
	tween.tween_callback(get_tree().change_scene_to_packed.bind(newScene))
