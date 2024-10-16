extends TextureButton

@export var DialogueText := "This is descriptive text"
@export var TextLabel :RichTextLabel


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
	pass
	
