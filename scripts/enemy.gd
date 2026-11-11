extends CharacterBody2D

@onready var collision = $CollisionShape2D
@onready var onScreen = $VisibleOnScreenNotifier2D
@onready var castL = $LeftCast
@onready var castR = $RightCast
@onready var sprite = $Sprite2D
@onready var timer = $Timer

var direction = -1
var speed = 50
var collided_with
var HP = 1
var CAN_HIT = true

func enemy_damage(dmg):
	HP -= dmg
	if HP < 1 and CAN_HIT:
		speed = 0
		timer.start(1)
		CAN_HIT = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not onScreen.is_on_screen():
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = direction * speed

	move_and_slide()

	if castL.is_colliding():
		direction = 1
		sprite.flip_h = direction > 0
		
		for i in castL.get_collision_count():
			collided_with = castL.get_collider(i)
			if collided_with.is_in_group("player") and CAN_HIT == true:
				Game.player_damage(1)
	
	if castR.is_colliding():
		direction = -1
		sprite.flip_h = direction > 0
		
		for i in castR.get_collision_count():
			collided_with = castR.get_collider(i)
			if collided_with.is_in_group("player"):
				Game.player_damage(1)

func _on_timer_timeout() -> void:
	queue_free()
