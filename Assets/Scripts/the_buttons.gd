extends Node2D

@export var up := true
@onready var upButton := $UpButton
@export var right := true
@onready var rightButton := $RightButton
@export var down := true
@onready var downButton := $DownButton
@export var left := true
@onready var leftButton := $LeftButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not up:
		upButton.hide()
		
	if not right:
		rightButton.hide()
		
	if not down:
		downButton.hide()
		
	if not left:
		leftButton.hide()
