class_name WeaponHolder
extends Node2D

@export var initial: PackedScene
@export var distance: float


# Called when the node enters the scene tree for the first time.
func _ready():
	set_weapon(initial.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	follow_cursor()


func set_weapon(weapon: Node2D) -> void:
	remove_child(get_child(0))
	weapon.position = Vector2(distance, 0)
	add_child(weapon)


func follow_cursor() -> void:
	look_at(get_global_mouse_position())
