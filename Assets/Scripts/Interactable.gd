extends TextureButton

@export var DialogueText := ["This is descriptive text"]
const DIABOX := preload("res://Assets/Scenes/DialogueBox.tscn")
var currTextIndex = 0
var spawnedBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(ClickedInteractable)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.is_hovered():
		self_modulate = Color(0.9, 0.9, 0.9)
	else:
		self_modulate = Color.WHITE

func ClickedInteractable():
	spawnedBox = DIABOX.instantiate()
	add_child(spawnedBox)
	spawnedBox.global_position = get_viewport().get_camera_2d().global_position
	spawnedBox.get_node("Panel/RichTextLabel").text = DialogueText[currTextIndex]
	currTextIndex += 1
	spawnedBox.get_node("Button").pressed.connect(AdvanceDialogue)

func AdvanceDialogue():
	if currTextIndex >= DialogueText.size():
		remove_child(spawnedBox)
		currTextIndex = 0
	else:
		spawnedBox.get_node("Panel/RichTextLabel").text = DialogueText[currTextIndex]
		currTextIndex += 1
