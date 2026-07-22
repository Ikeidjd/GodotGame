extends AnimatedSprite2D

@export var arrow: PackedScene
@export var cooldown_timer: Timer
var max_damage: float = 1.5
var frames: int = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	play("loaded")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("bow"):
		if animation == "loaded":
			play("pulling")
	elif event.is_action_released("bow"):
		var progress: float

		match animation:
			"pulling": progress = float(max(1, frame)) / frames
			"pulled": progress = 1
			_: return

		get_tree().root.add_child(new_arrow(progress))

		play("empty")
		cooldown_timer.start()


func new_arrow(progress: float) -> Arrow:
	var instance: Arrow = arrow.instantiate()

	instance.damage = max_damage * progress
	instance.velocity = Vector2(instance.speed * progress, 0).rotated(get_parent().rotation)
	instance.position = global_position
	instance.rotation = get_parent().rotation

	return instance


func _on_cooldown_timer_timeout() -> void:
	play("loaded")


func _on_animation_finished() -> void:
	if animation == "pulling":
		play("pulled")
