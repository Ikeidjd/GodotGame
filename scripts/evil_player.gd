extends CharacterBody2D

@export var animator: CharacterAnimator
@export var player: Player
@export var speed: float



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	velocity = (player.position - position).normalized() * speed

	if abs(player.position.x - position.x) <= abs(speed * delta * 4):
		velocity.x = 0.0

	if abs(player.position.y - position.y) <= abs(speed * delta * 4):
		velocity.y = 0.0

	animator.play_animation(velocity)
	move_and_slide()
