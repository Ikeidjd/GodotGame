extends CharacterBody2D

@export var animator: CharacterAnimator
@export var player: Player
@export var speed: float



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float):
	velocity = (player.position - position).normalized() * speed
	animator.play_animation(velocity)
	move_and_slide()
