extends Node2D

@onready var reload_timer: Timer = $DetectionArea/ReloadTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reload_timer.timeout.connect(restart_current_scene)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		restart_current_scene() # Replace with function body.

func restart_current_scene() -> void:
	get_tree().reload_current_scene()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		reload_timer.start()
