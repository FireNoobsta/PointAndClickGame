extends Node2D
#Simple script that binds a given button's pressed signal to setting the visiblity to a given value
@export var button : BaseButton
@export var visibility := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if button:
		button.pressed.connect(SetVisibility.bind(visibility))
	else:
		print("WARNING: ToggleVisibility script not given button -> " + str(self))

func SetVisibility(value):
	self.visible = value
