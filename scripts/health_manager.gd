class_name HealthManager
extends Node

@export var entity: Node2D
@export var hurt_box: Area2D

@export var invincibility_timer: Timer
@export var flicker_timer: Timer

@export var hit_sound: AudioStreamPlayer
@export var initial_health: float

@onready var health: float = initial_health
var invincible: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	hurt_box.area_entered.connect(_on_hurt_box_entered)
	hurt_box.body_entered.connect(_on_hurt_box_entered)


func _on_hurt_box_entered(node: Node2D):
	if !invincible and (node.collision_layer & 0b10) != 0:
		var damage = 1

		if "damage" in node:
			damage = node.damage

		health -= damage

		invincible = true
		invincibility_timer.start()
		flicker_timer.start()

		hit_sound.play()
		entity.hide()


func _on_invincibility_timer_timeout():
	flicker_timer.stop()
	invincible = false
	entity.show()


func _on_flicker_timer_timeout():
	if health > 0:
		entity.visible = !entity.visible


func _on_hit_sound_finished():
	if health <= 0:
		entity.queue_free()
