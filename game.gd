extends Node2D

@export var controller_active : bool = false
var STICK_DEADZONE : float = 0.2
var direction : Vector2

var player
var shootable
var damage_cooldown = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	shootable = get_tree().get_first_node_in_group("shootable")

func player_damage(dmg):
	player.player_damage(dmg)

func enemy_damage(dmg):
	shootable.enemy_damage(dmg)

func _input(event: InputEvent) -> void:
	# Detect controller activation
	if (event is InputEventJoypadButton and event.pressed) or (event is InputEventJoypadMotion and abs(event.axis_value) > STICK_DEADZONE):
		controller_active = true
	elif (event is InputEventKey and event.pressed) or (event is InputEventMouseButton and event.pressed):
		controller_active = false

	# Block keyboard input while controller is active
	if controller_active and event is InputEventKey:
		get_viewport().set_input_as_handled()
