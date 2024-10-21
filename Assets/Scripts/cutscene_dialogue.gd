extends Node2D

@export_multiline var DialogueText : Array[String] = ["This is descriptive text"]
@export var startOnReady := false
@export var triggerButton : BaseButton

const DIABOX := preload("res://Assets/Scenes/DialogueBox.tscn")
var spawnedBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if startOnReady:
		SpawnBox()
	elif triggerButton:
		triggerButton.pressed.connect(SpawnBox)
	else:
		print("WARNING: Cutscene Dialogue " + str(self) + " has no trigger and will never start")

func SpawnBox():
	spawnedBox = DIABOX.instantiate()
	add_child(spawnedBox)
	spawnedBox.SetDialogue(DialogueText)
	spawnedBox.StartDialogue()
	
