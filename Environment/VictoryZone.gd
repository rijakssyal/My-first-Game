extends Area3D

@export_file("*.tscn") var NEXT_LEVEL: String = ""
var can_trigger: bool = false

func _ready() -> void:
	body_entered.connect(_on_VictoryZone_body_entered.unbind(1))
	# Wait 0.5 seconds after the level loads before allowing a win
	await get_tree().create_timer(0.5).timeout
	can_trigger = true

func _on_VictoryZone_body_entered() -> void:
	if not can_trigger:
		return
		
	if NEXT_LEVEL != "":
		can_trigger = false # Prevents double-triggering
		get_tree().call_deferred("change_scene_to_file", NEXT_LEVEL)
