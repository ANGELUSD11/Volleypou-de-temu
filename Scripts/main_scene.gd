extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		restart_current_scene() # Replace with function body.

func restart_current_scene() -> void:
	get_tree().reload_current_scene()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		get_tree().call_deferred("reload_current_scene")
