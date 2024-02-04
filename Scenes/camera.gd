extends Camera2D

@export_group("limits")
@export var leftLimit: Node
@export var rightLimit: Node
@export var upperLimit: Node
@export var downerLimit: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	var death = get_tree().current_scene.get_node("DeathZone/CollisionShape2D")
	limit_bottom = death.global_position.y
	
	#set camera boundaries
	if leftLimit: limit_left = leftLimit.global_position.x
	if rightLimit: limit_right = rightLimit.global_position.x
	if upperLimit: limit_top = upperLimit.global_position.y
	if downerLimit: limit_bottom = downerLimit.global_position.y

