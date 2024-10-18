extends RigidBody2D

@onready var button := $TextureButton
var localForcePoint : Vector2
var globalForcePoint : Vector2
var forceDirection : Vector2
var mousePos : Vector2
var distFromPoint := 0.0
var isDragging = false
@export var maxForce = 5.0
@export var maxDistance = 50.0
var forceMagnitude = 0.0
var forceToApply : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.button_down.connect(OnButtonDown)
	button.button_up.connect(OnButtonUp)

func OnButtonDown():
	print("button down")
	localForcePoint = self.to_local(get_global_mouse_position())
	isDragging = true
	
func OnButtonUp():
	print("button up")
	isDragging = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if isDragging:
		mousePos = get_global_mouse_position()
		globalForcePoint = to_global(localForcePoint)
		forceDirection = (mousePos - globalForcePoint).normalized()
		distFromPoint = (mousePos - globalForcePoint).length()
		forceMagnitude = clamp(lerp(0.0, maxForce, distFromPoint / maxDistance), 0.0, maxForce)
		forceToApply = forceDirection * forceMagnitude * delta
		self.apply_force(forceToApply, (globalForcePoint - self.global_position))
		print("applied force")
		print("Magnitude: " + str(forceMagnitude) + "\n Force Vector: " + str(forceToApply))
		
