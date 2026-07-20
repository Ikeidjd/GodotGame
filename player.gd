extends Node2D


var speed: float = 80


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var vel = Vector2.ZERO
	
	if Input.is_action_pressed("walk_up"):
		vel.y -= 1
	if Input.is_action_pressed("walk_left"):
		vel.x -= 1
	if Input.is_action_pressed("walk_down"):
		vel.y += 1
	if Input.is_action_pressed("walk_right"):
		vel.x += 1
	
	position += vel.normalized() * speed * delta
	play_animation(vel)


func play_animation(vel: Vector2):
	if vel.y > 0:
		$AnimationPlayer.play("walk_down")
	elif vel.y < 0:
		$AnimationPlayer.play("walk_up")
	elif vel.x > 0:
		$AnimationPlayer.play("walk_right")
	elif vel.x < 0:
		$AnimationPlayer.play("walk_left")
