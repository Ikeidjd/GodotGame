class_name Player
extends CharacterBody2D

enum MovementState {
	Normal,
	Dash,
}

@export var animator: CharacterAnimator
@export var weapon_holder: WeaponHolder
@export var speed: float
@export var dash_speed: float
var movement_state: MovementState = MovementState.Normal


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float):
	match movement_state:
		MovementState.Normal: _move_normal()
		MovementState.Dash: pass

	move_and_slide()


func _move_normal() -> void:
	velocity = Vector2.ZERO

	if Input.is_action_pressed("walk_up"):
		velocity.y -= 1
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1
	if Input.is_action_pressed("walk_down"):
		velocity.y += 1
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1

	velocity = velocity.normalized() * speed
	animator.play_animation(velocity)


func begin_dash(towards: Vector2, duration: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "velocity", (towards - position).normalized() * dash_speed, duration / 5)
	tween.tween_callback(func(): animator.play_animation(velocity))
	tween.tween_await(get_tree().create_timer(duration).timeout)
	tween.parallel().tween_property(animator, "rotation", 2 * PI, duration)
	tween.tween_property(animator, "rotation", 0, 0)
	tween.tween_property(self, "velocity", Vector2.ZERO, duration / 5)

	movement_state = MovementState.Dash
	await get_tree().create_timer(duration * 7 / 5).timeout
	movement_state = MovementState.Normal
