extends CharacterBody2D

const TILE_SIZE = 32
const MOVE_SPEED = 200


var moving = false
var target_position: Vector2
var direction: Vector2 = Vector2.ZERO

func _ready():
	position = position.snapped(Vector2(TILE_SIZE, TILE_SIZE))

func _physics_process(delta):
	if !moving:
		handle_input()
	else:
		move_to_target(delta)
		
func handle_input():
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		input_dir = Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		input_dir = Vector2.DOWN
	elif Input.is_action_pressed("ui_left"):
		input_dir = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"):
		input_dir = Vector2.RIGHT
		
	if input_dir != Vector2.ZERO:
		direction = input_dir
		target_position = position + input_dir * TILE_SIZE
		moving = true
		
func move_to_target(_delta):
	var move_vector = (target_position - position).normalized()
	velocity = move_vector * MOVE_SPEED
	move_and_slide()
	
	if position.distance_to(target_position) < 2:
		position = target_position
		velocity = Vector2.ZERO
		moving = false
