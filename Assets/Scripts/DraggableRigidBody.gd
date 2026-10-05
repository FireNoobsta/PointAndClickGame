extends RigidBody2D

@onready var button : TextureButton = $TextureButton
var localForcePoint : Vector2
var globalForcePoint : Vector2
var forceDirection : Vector2
var mousePos : Vector2
var distFromPoint := 0.0
var isDragging = false
@export var maxForce = 100.0
@export var maxDistance = 50.0
@export var maxlinearDamp = 500.0
var logOfMaxDist
var forceMagnitude = 0.0
var forceToApply : Vector2
var defaultLinearDamp
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.button_down.connect(OnButtonDown)
	button.button_up.connect(OnButtonUp)
	defaultLinearDamp = self.linear_damp
	logOfMaxDist = log(maxDistance)
	#print("default linear damp: " + str(defaultLinearDamp))

func OnButtonDown():
	#print("button down")
	localForcePoint = self.to_local(get_global_mouse_position())
	isDragging = true
	
func OnButtonUp():
	#print("button up")
	isDragging = false

func _process(_delta: float) -> void:
	if isDragging:
		self.modulate = Color.YELLOW
	elif button.is_hovered():
		self.modulate = Color(0.9, 0.9, 0.9)
	else:
		self.modulate = Color.WHITE

func DampingFunction():
	return log(distFromPoint) / logOfMaxDist

func _physics_process(delta: float) -> void:
	if isDragging:
		mousePos = get_global_mouse_position()
		globalForcePoint = to_global(localForcePoint)
		forceDirection = (mousePos - globalForcePoint).normalized()
		distFromPoint = (mousePos - globalForcePoint).length()
		forceMagnitude = clamp(lerp(0.0, maxForce, distFromPoint / maxDistance), 0.0, maxForce)
		self.linear_damp = clamp(lerp(maxlinearDamp, defaultLinearDamp, DampingFunction()), defaultLinearDamp, maxlinearDamp)
		self.angular_damp = clamp(lerp(maxlinearDamp, defaultLinearDamp, DampingFunction()), defaultLinearDamp, maxlinearDamp)
		
		forceToApply = forceDirection * forceMagnitude * delta
		self.apply_force(forceToApply, (globalForcePoint - self.global_position))
		
		#print("applied force")
		#print("Magnitude: " + str(forceMagnitude) + "\n Force Vector: " + str(forceToApply))
	else:
		self.linear_damp = defaultLinearDamp
		self.angular_damp = defaultLinearDamp
