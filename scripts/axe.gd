extends Sprite2D

@export var cooldown_timer: Timer
@export var dash_duration: float = 0.5
var allow_dash = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if allow_dash and event.is_action_pressed("use_weapon"):
		var player: Player = get_parent().player
		player.begin_dash(get_global_mouse_position(), dash_duration)
		allow_dash = false
		await get_tree().create_timer(dash_duration).timeout
		cooldown_timer.start()


func _on_cooldown_timer_timeout() -> void:
	allow_dash = true
