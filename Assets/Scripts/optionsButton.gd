extends Button

@onready var optionsPanel := $Panel
@onready var backButton := $Panel/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	optionsPanel.hide()
	self.pressed.connect(OpenOptions)
	backButton.pressed.connect(CloseOptions)

func OpenOptions():
	optionsPanel.show()
	

func CloseOptions():
	optionsPanel.hide()
	
