extends Sprite2D

@onready var rigidBody = $".."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.position = rigidBody.center_of_mass
