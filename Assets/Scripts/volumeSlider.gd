extends HSlider

#@export var audioBusLayout : AudioBusLayout

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(0.50))


func _value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(new_value / 100.0))
