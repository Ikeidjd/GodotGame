extends TextureProgressBar

@export var health_manager: HealthManager


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	value = health_manager.health * 100 / health_manager.initial_health
