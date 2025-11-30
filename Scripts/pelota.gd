extends RigidBody2D

#raycast reference
@onready var raycast: RayCast2D = $RayCast2D
var max_speed: float = 1000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze = true # Replace with function body.
	raycast.top_level = true
	
func _physics_process(delta: float) -> void:
	if freeze:
		return
		
	raycast.global_position = global_position
	raycast.target_position = linear_velocity * delta * 1.5
	raycast.force_raycast_update()
	
	if raycast.is_colliding():
		var normal = raycast.get_collision_normal()
		
		if linear_velocity.dot(normal) < 0:
			_forzar_rebote_manual(normal)
			
func _forzar_rebote_manual(normal_pared):
	var velocidad_actual = linear_velocity
	var velocidad_rebote = velocidad_actual.bounce(normal_pared)
	
	linear_velocity = velocidad_rebote
	global_position += normal_pared * 2.0
	
func _integrate_forces(state):
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed

func _on_body_entered(body: Node) -> void:
	if freeze == true:
		if body.is_in_group("player"):
			move_ball()
		
func move_ball():
	set_deferred("freeze", false)
