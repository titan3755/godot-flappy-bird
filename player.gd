extends Area2D

signal hit

@export var horizontal_speed:int
@export var horizontal_friction:int
@export var jump_acceleration:int = 0
@export var acceleration_duetogravity:int
var velocity = Vector2.ZERO
var screen_size
var left_held = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_left"):
		velocity.x -= horizontal_speed
	if Input.is_action_pressed("move_right"):
		velocity.x += horizontal_speed
	if Input.is_action_just_pressed("jump"):
		velocity.y -= jump_acceleration
		
	if velocity.y == 0:
		$AnimatedSprite2D.play("flat")
	if velocity.y < 0:
		$AnimatedSprite2D.play("flying")
	if velocity.y > 0:
		$AnimatedSprite2D.play("falling")
		
	position.x += velocity.x * delta
	position.y += velocity.y * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	velocity.y += acceleration_duetogravity
	if velocity.x > 0:
		velocity.x -= horizontal_friction
	if velocity.x < 0:
		velocity.x += horizontal_friction
	velocity = velocity.clamp(Vector2(-acceleration_duetogravity * 50, -acceleration_duetogravity * 50), Vector2(acceleration_duetogravity * 50, acceleration_duetogravity * 50))


func _on_body_entered(_body):
	game_over()
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func game_over():
	pass #todo
