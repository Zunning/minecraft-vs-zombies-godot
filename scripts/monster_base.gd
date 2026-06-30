class_name Monster
extends CharacterBody2D

enum State { WALKING, ATTACKING, OTHER }

var current_state: State = State.WALKING
var move_speed: float = 50.0
var health: float = 100.0
var attack_damage: float = 10.0
var attack_cooldown: float = 1.0

var _attack_timer: float = 0.0
var _target = null

func _physics_process(delta):
	match current_state:
		State.WALKING:
			_do_walk(delta)
		State.ATTACKING:
			_do_attack(delta)

func _do_walk(delta):
	velocity = Vector2(-1, 0) * move_speed
	move_and_slide()

func _do_attack(delta):
	if not is_instance_valid(_target):
		_target = null
		current_state = State.WALKING
		return
	
	_attack_timer -= delta
	if _attack_timer <= 0:
		_attack_timer = attack_cooldown
		_target.damage(attack_damage)

func _on_area_2d_body_entered(body):
	if body.is_in_group("contraption"):
		_target = body
		current_state = State.ATTACKING

func take_damage(amount: float):
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()
