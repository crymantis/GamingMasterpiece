extends CharacterBody2D

const SPEED = 300.0
@export var DASH_IMPULSE_VELOCITY = 500
const JUMP_VELOCITY = -400.0

# Dash controlling variables
@export var maxDashes = 1
var remainingDashes = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _input(event):
	# dash
	if event.is_action_pressed("ui_dash"):
		if remainingDashes > 0:
			velocity = get_dash_vector() * DASH_IMPULSE_VELOCITY
			remainingDashes -= 1

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# When grounded
	if is_on_floor():
		remainingDashes = maxDashes

	# Handle jump.
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	player_animations()
	# print(get_dash_vector())

func get_dash_vector():
	var vec = Vector2(0,0)
	vec.x = Input.get_axis("ui_left", "ui_right")
	vec.y = Input.get_axis("ui_up", "ui_down")
	
	return vec

# Animations
func player_animations():
	#on left (add is_action_just_released so you continue running after jumping)
	if Input.is_action_pressed("ui_left") || Input.is_action_just_released("ui_up"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walking")

		#on right (add is_action_just_released so you continue running after jumping)
	if Input.is_action_pressed("ui_right") || Input.is_action_just_released("ui_up"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walking")
		
	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("idle")
	
	if !is_on_floor() and velocity.y != 0:
		$AnimatedSprite2D.play("jumping")
