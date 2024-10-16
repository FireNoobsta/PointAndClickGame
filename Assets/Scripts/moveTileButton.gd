extends TextureButton

#export var destination := 
#@onready var Camera := $"../Camera2D"
@export var DestinationCamera :Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(self.MoveCamera)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func MoveCamera():
	DestinationCamera.make_current()
	
