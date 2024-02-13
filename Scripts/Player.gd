extends CharacterBody2D

const SPEED = 500.0
@export var DASH_IMPULSE_VELOCITY = 400
const JUMP_VELOCITY = -650.0
@export var acceleration = 3
@export var terminalVelocity = 8000
@export var wallVelocity = 200
@export var wallJumpVelocity: Vector2 = Vector2(550.0,-1550.0)

# Dash controlling variables
@export var maxDashes = 1
var remainingDashes = 1
@export var dashExpiryTime = 0.2
@export var timeSinceDash = dashExpiryTime

@export_group("World References")
@export var respawnPoint: Node

@export var deathZone: Node

# State management
var isWallSliding = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _input(event):
	# dash
	if event.is_action_pressed("ui_dash"):
		if remainingDashes > 0 and timeSinceDash > dashExpiryTime:
			var dashVector = get_dash_vector()
			print("before", velocity)
			velocity = dashVector * DASH_IMPULSE_VELOCITY
			print("after", velocity)
			
			timeSinceDash = 0
			remainingDashes -= 1

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += (gravity * delta)*2
	
	# When grounded
	if is_on_floor():
		remainingDashes = maxDashes
		
	if is_on_wall() and Input.get_axis("ui_left", "ui_right") != 0:
		isWallSliding = true
	else:
		isWallSliding = false

	# Handle jump.
	handle_jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if timeSinceDash > dashExpiryTime:
		velocity.x = move_toward(velocity.x, direction * SPEED, acceleration)

	manage_dash_timing(delta)
	move_and_slide()
	player_animations()
	clamp_velocity()
	
func handle_jump():
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("ui_jump") and isWallSliding == true:
		isWallSliding = false
		if Input.get_axis("ui_left", "ui_right") < 0:
			velocity = wallJumpVelocity
		elif Input.get_axis("ui_left", "ui_right") > 0:
			velocity = wallJumpVelocity * Vector2(-1,1)

func clamp_velocity():
	if isWallSliding:
		velocity.y = clamp(velocity.y,-wallVelocity,wallVelocity)
	else:
		velocity.y = clamp(velocity.y,-terminalVelocity,terminalVelocity)

func manage_dash_timing(delta):
	timeSinceDash += delta

func get_dash_vector():
	var vec = Vector2(0,0)
	vec.x = Input.get_axis("ui_left", "ui_right")
	vec.y = Input.get_axis("ui_up", "ui_down")
	if vec.length() == 0:
		if $AnimatedSprite2D.flip_h:
			vec.x = -1
		else:
			vec.x = 1
	
	
	return vec.normalized()

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
		
func respawn():
	set_position(respawnPoint.position)

func _onDeath(body):
	respawn()
