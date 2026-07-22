class_name CharacterAnimator
extends AnimatedSprite2D

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

var state: State = State.Idle
var direction: Direction = Direction.Down


func play_animation(velocity: Vector2):
	if velocity == Vector2.ZERO:
		state = State.Idle
	else:
		state = State.Walk

	# This way, no axis has that much inherent priority over the other, since it's the most intense that one takes priority
	if abs(velocity.y) >= abs(velocity.x):
		if velocity.y > 0:
			direction = Direction.Down
		elif velocity.y < 0:
			direction = Direction.Up
	else:
		if velocity.x > 0:
			direction = Direction.Right
		elif velocity.x < 0:
			direction = Direction.Left

	var animation_name = "_"

	match state:
		State.Idle: animation_name = "idle" + animation_name
		State.Walk: animation_name = "walk" + animation_name

	match direction:
		Direction.Up: animation_name += "up"
		Direction.Down: animation_name += "down"
		Direction.Left: animation_name += "left"
		Direction.Right: animation_name += "right"

	play(animation_name)
