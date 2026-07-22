class_name Arrow
extends CharacterBody2D

@export var speed: float
var damage: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if move_and_collide(velocity * delta) != null:
		queue_free()


func _on_life_timer_timeout() -> void:
	queue_free()
