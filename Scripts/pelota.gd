extends RigidBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var radio: float = 30.0
var max_speed: float = 200.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# 1. Rotación Visual (Cosmético)
	if not freeze:
		var velocidad_angular = linear_velocity.x / radio
		sprite.rotation += velocidad_angular * delta
	else:
		return # Si está congelada, no calculamos nada más

func _on_body_entered(body: Node) -> void:
	if freeze == true:
		if body.is_in_group("player"):
			move_ball()

func move_ball():
	set_deferred("freeze", false)
