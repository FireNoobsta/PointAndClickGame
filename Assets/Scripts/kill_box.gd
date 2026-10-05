extends Area2D

func _ready() -> void:
	self.body_entered.connect(_on_enter)

func _on_enter(body: Node2D):
	body.translate(self.global_position - body.global_position)
	print("Body Teleported!")
