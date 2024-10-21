extends Node2D

@export_multiline var DialogueText : Array[String] = ["This is descriptive text"]
var currTextIndex := 0

signal dialogue_closed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func SetDialogue(newDialogue : Array[String]):
	DialogueText.clear()
	DialogueText.append_array(newDialogue)

func StartDialogue():
	#global_position = get_viewport().get_camera_2d().global_position
	currTextIndex = 0
	get_node("CanvasLayer/Panel/RichTextLabel").text = DialogueText[currTextIndex]
	currTextIndex += 1
	get_node("CanvasLayer/Button").pressed.connect(AdvanceDialogue)

func AdvanceDialogue():
	if currTextIndex >= DialogueText.size():
		dialogue_closed.emit()
		queue_free()
	else:
		get_node("CanvasLayer/Panel/RichTextLabel").text = DialogueText[currTextIndex]
		currTextIndex += 1
