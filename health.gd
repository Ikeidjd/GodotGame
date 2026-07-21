extends Node

@export var entity: Node2D
@export var invincibility_timer: Timer
@export var flicker_timer: Timer
@export var hit_sound: AudioStreamPlayer
@export var initial_health: float
var health: float
var invincible: bool


# Called when the node enters the scene tree for the first time.
func _ready():
	health = initial_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hurt_box_area_entered(area: Area2D):
	if !invincible and (area.collision_layer & 0b10) != 0:
		health -= 1
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
	if health == 0:
		entity.queue_free()
