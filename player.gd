extends CharacterBody2D

enum State {
	Idle,
	Walk,
}

enum Direction {
	Up,
	Down,
	Left,
	Right,
}

var speed: float = 80.0
var state: State = State.Idle
var direction: Direction = Direction.Down


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
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
	play_animation()
	move_and_slide()


func play_animation():
	if velocity == Vector2.ZERO:
		state = State.Idle
	else:
		state = State.Walk

	if velocity.y > 0:
		direction = Direction.Down
	elif velocity.y < 0:
		direction = Direction.Up
	elif velocity.x > 0:
		direction = Direction.Right
	elif velocity.x < 0:
		direction = Direction.Left

	var animation = "_"

	match state:
		State.Idle: animation = "idle" + animation
		State.Walk: animation = "walk" + animation

	match direction:
		Direction.Up: animation += "up"
		Direction.Down: animation += "down"
		Direction.Left: animation += "left"
		Direction.Right: animation += "right"

	$AnimatedSprite2D.play(animation)
