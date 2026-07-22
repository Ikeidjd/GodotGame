class_name Player
extends CharacterBody2D

@export var animator: CharacterAnimator
@export var weapon_holder: WeaponHolder
@export var speed: float


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float):
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
	move_and_slide()
