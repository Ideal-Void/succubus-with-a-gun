extends CharacterBody2D

@onready var timer = $Timer
@onready var healthbar = $Camera2D/hud/HealthBar
@onready var healthtext = $Camera2D/hud/HealthBar/Number
@onready var feet = $FootCollider

var BASE_MAX_SPEED = 200.0
var MAX_SPEED = BASE_MAX_SPEED
var SPRINT_MULTIPLIER = 1.5
var MAX_AIRJUMPS = 1
var AIRJUMPS = MAX_AIRJUMPS
var SPEED = 0.0
var ACCEL = 10.0
var BASE_JUMP_VELOCITY = -300.0
var JUMP_VELOCITY = BASE_JUMP_VELOCITY
var MAX_HP = 5
var HP = MAX_HP
var INVULN = 2
var CAN_HIT = true
var DEAD = false
var collided_with

func _ready():
	healthbar.max_value = MAX_HP
	healthbar.value = HP
	healthtext.text = str(HP)

func player_damage(dmg):
	if CAN_HIT and not DEAD:
		HP -= dmg
		healthbar.value = HP
		healthtext.text = str(HP)
		CAN_HIT = false
		timer.start(INVULN)
	if HP < 1:
		DEAD = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if is_on_floor():
		AIRJUMPS = MAX_AIRJUMPS
	else:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("player_jump") and not DEAD:
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif AIRJUMPS > 0:
			AIRJUMPS -= 1
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("player_left", "player_right")
	if direction and not DEAD:
		# Handle sprint.
		if Input.is_action_pressed("player_sprint"):
			MAX_SPEED = BASE_MAX_SPEED * SPRINT_MULTIPLIER
			JUMP_VELOCITY = BASE_JUMP_VELOCITY * SPRINT_MULTIPLIER
		else:
			MAX_SPEED = BASE_MAX_SPEED
			JUMP_VELOCITY = BASE_JUMP_VELOCITY
			
		velocity.x = move_toward(0, direction * SPEED, SPEED)
		if SPEED <= MAX_SPEED:
			SPEED += ACCEL
		else:
			SPEED -= ACCEL
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if SPEED > 0:
			SPEED -= ACCEL
		MAX_SPEED = BASE_MAX_SPEED
		JUMP_VELOCITY = BASE_JUMP_VELOCITY

	if feet.is_colliding():
		for i in feet.get_collision_count():
			collided_with = feet.get_collider(i)
			if collided_with.is_in_group("stompable"):
				Game.stomp_damage(1)

	move_and_slide()


func _on_timer_timeout() -> void:
	CAN_HIT = true
